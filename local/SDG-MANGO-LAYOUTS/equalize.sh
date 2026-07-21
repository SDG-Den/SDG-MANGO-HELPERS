#!/bin/bash

ARG="$1"
ACTIVEMON="$2"

if [ "$ACTIVEMON" == "" ]; then
	ACTIVEMON=$(mmsg get all-monitors | jq '.monitors[] | select(.active == true) | .name' -r)
fi
ACTIVETAG=$(mmsg get tags $ACTIVEMON | jq '.tags[] | select(.is_active == true) | .index' -r)
WINDOWS=$(mmsg get all-clients | jq -r --arg ACTIVETAG "$ACTIVETAG" --arg ACTIVEMON "$ACTIVEMON" '.clients[] | select(.tags[] == ($ACTIVETAG | tonumber) and .monitor == $ACTIVEMON) | .id')

echo "active monitor is $ACTIVEMON, active tag is $ACTIVETAG"
echo ""
echo "windows are:"
echo "$WINDOWS"

Y_STRING=""
X_STRING=""

for WINDOW in $WINDOWS; do
	Y=$(mmsg get client $WINDOW | jq '.y')
	X=$(mmsg get client $WINDOW | jq '.x')
	Y_STRING="$Y_STRING
	$Y"
	X_STRING="$X_STRING
	$X"
done

echo ""
echo "x string is:"
echo "$X_STRING"
echo ""
echo "y string is:"
echo "$Y_STRING"
echo ""


Y_OPTS=$(echo "$Y_STRING" | tail -n +2 | sort | uniq)
X_OPTS=$(echo "$X_STRING" | tail -n +2 | sort | uniq)

Y_COUNT=$(echo "$Y_OPTS" | wc -l)
X_COUNT=$(echo "$X_OPTS" | wc -l)
echo "x count is $X_COUNT, y count is $Y_COUNT"

Y_RES=$(xrandr | grep -e "$ACTIVEMON" | cut -d' ' -f3 | cut -d+ -f1 | cut -dx -f2)
X_RES=$(xrandr | grep -e "$ACTIVEMON" | cut -d' ' -f3 | cut -d+ -f1 | cut -dx -f1)
echo "res is $X_RES by $Y_RES"

X_RES=$((X_RES + 0 - 8 ))
Y_RES=$((Y_RES + 0 - 8 ))

X_RESULT=$(( X_RES / X_COUNT))
Y_RESULT=$(( Y_RES / Y_COUNT))
echo "window size adjustment: X = $X_RESULT, Y = $Y_RESULT" 

case $ARG in
	vertical|v)
		VERT="TRUE"
		HOR="FALSE"
		;;
	horizontal|h)
		VERT="FALSE"
		HOR="TRUE"
		;;
	both|b)
		VERT="TRUE"
		HOR="TRUE"
		;;
esac

LOOPCOUNT=0

#WINDOWS=$(echo "$WINDOWS" | sort -r)
while true; do

	WINDOWS=$(echo "$WINDOWS" | sort -R)

	for WINDOW in $WINDOWS; do
		if [ "$HOR" == "TRUE" ]; then
			KEEP=$(mmsg get client $WINDOW | jq '.height')
			CURRENT=$(mmsg get client $WINDOW | jq '.width')
			FINAL=$((CURRENT - X_RESULT))
			mmsg dispatch resizewin,$FINAL,0 client,$WINDOW
			echo "applying X = $FINAL to $WINDOW to get from $CURRENT to $X_RESULT"
		fi
		if [ "$VERT" == "TRUE" ]; then
			KEEP=$(mmsg get client $WINDOW | jq '.width')
			CURRENT=$(mmsg get client $WINDOW | jq '.height')
			final=$((CURRENT - Y_RESULT))
			mmsg dispatch resizewin,0,$FINAL client,$WINDOW
			echo "applying Y = $FINAL to $WINDOW to get from $CURRENT to $Y_RESULT"
		fi
		sleep 1
	done
	
	DONE="TRUE"

	for WINDOW in $WINDOWS; do
		if [ "$HOR" == "TRUE" ]; then
			CURRENT=$(mmsg get client $WINDOW | jq '.width')
			MIN=$((X_RESULT - 10))
			MAX=$((X_RESULT + 10))
			echo "comparing current X $CURRENT for window $WINDOW to min $MIN and max $MAX"
			if [ $CURRENT -le $MIN ] || [ $CURRENT -ge $MAX ]; then
				DONE="FALSE"
				echo "failed"
			fi
		fi
		if [ "$VERT" == "TRUE" ]; then
			CURRENT=$(mmsg get client $WINDOW | jq '.height')
			MIN=$((Y_RESULT - 5))
			MAX=$((Y_RESULT + 5))
			echo "comparing current Y $CURRENT for window $WINDOW to min $MIN and max $MAX"
			if [ $CURRENT -le $MIN ] || [ $CURRENT -ge $MAX ]; then
				DONE="FALSE"
				echo "failed"
			fi
		fi
	done

	if [ "$DONE" == "TRUE" ]; then
		echo "windows should be equalized"
		exit 0
	fi
	if [ "$LOOPCOUNT" == "10" ]; then
		echo "loopcount reached"
		exit 0
	fi
	LOOPCOUNT=$((LOOPCOUNT + 1))
done



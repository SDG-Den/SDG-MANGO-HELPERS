#!/bin/bash

ARG="$1"
ACTIVEMON="$2"

if [ "$ACTIVEMON" == "" ]; then
	ACTIVEMON=$(mmsg get all-monitors | jq '.monitors[] | select(.active == true) | .name' -r)
fi
ACTIVETAG=$(mmsg get tags $ACTIVEMON | jq '.tags[] | select(.is_active == true) | .index' -r)
WINDOWS=$(mmsg get all-clients | jq -r --arg ACTIVETAG "$ACTIVETAG" --arg ACTIVEMON "$ACTIVEMON" '.clients[] | select(.tags[] == ($ACTIVETAG | tonumber) and .monitor == $ACTIVEMON) | .id')

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

Y_OPTS=$(echo "$Y_STRING" | sort | uniq)
X_OPTS=$(echo "$X_STRING" | sort | uniq)

Y_COUNT=$(echo "$Y_OPTS" | wc -l)
X_COUNT=$(echo "$X_OPTS" | wc -l)

Y_RES=$(xrandr | grep -e "$ACTIVEMON" | cut -d' ' -f2 | cut -d+ -f1 | cut -dx -f2)
X_RES=$(xrandr | grep -e "$ACTIVEMON" | cut -d' ' -f2 | cut -d+ =f1 | cut -dx -f1)

X_RES=$((X_RES + 0 - 8 ))
Y_RES=$((Y_RES + 0 - 8 ))

X_RESULT=$(( X_RES / X_COUNT))
Y_RESULT=$(( Y_RES / Y_COUNT))

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

for WINDOW in $WINDOWS; do
	if [ $HOR == "TRUE" ]; then
		KEEP=$(mmsg get client $WINDOW | jq '.height')
		mmsg dispatch resizewin,$X_RESULT,$KEEP client,$WINDOW
	fi
	if [ $VERT == "TRUE" ]; then
		KEEP=$(mmsg get client $WINDOW | jq '.width')
		mmsg dispatch resizewin,$KEEP,Y_RESULT client,$WINDOW
	fi
done

echo "windows should be equalized now."


#!/bin/bash
#notify-send "triggered"
ACTIVEMON="$2"

if [ "$ACTIVEMON" == "" ]; then
	ACTIVEMON=$(mmsg get all-monitors | jq '.monitors[] | select(.active == true) | .name' -r)
fi
ACTIVETAG=$(mmsg get tags "$ACTIVEMON" | jq '.tags[] | select(.is_active == true) | .index' -r)

VALUES="1=1
2=0.498
3=0.332
4=0.248
5=0.197
6=0.165
7=0.141
8=0.123
9=0.109
10=0.098"
echo "active monitor is $ACTIVEMON, active tag is $ACTIVETAG"


update_size() {


	WINDOWS=$(mmsg get all-clients | jq -r --arg ACTIVETAG "$ACTIVETAG" --arg ACTIVEMON "$ACTIVEMON" '.clients[] | select(.tags[] == ($ACTIVETAG | tonumber) and .monitor == $ACTIVEMON) | .id')
	Y_STRING=""
	echo "windows are:"
	echo "$WINDOWS"
	for WINDOW in $WINDOWS; do
		Y=$(mmsg get client "$WINDOW" | jq '.x')
		Y_STRING="$Y_STRING
$Y"
	done
	echo "Y string is:"
	echo "$Y_STRING"
	Y_OPTS=$(echo "$Y_STRING" | tail -n +2 | sort | uniq)
	echo "Y opts is:"
	echo "$Y_OPTS"
	Y_COUNT=$(echo "$Y_OPTS" | wc -l)
	echo "y count is $Y_COUNT"

	CURRENT=$(mmsg get focusing-client | jq -r '.scroller_proportion')
	EXPECTED=$(echo "$VALUES" | grep -e "^$Y_COUNT=" | cut -d= -f2)
	if [ "$CURRENT" != "$EXPECTED" ]; then
		for WINDOW in $WINDOWS; do
			mmsg dispatch set_proportion,$EXPECTED client,$WINDOW
			echo "set client $WINDOW to value $EXPECTED"
		done
	fi

	FOCUSED=$(mmsg get focusing-client | jq -r '.id')
	for WINDOW in $WINDOWS; do
		mmsg dispatch focusid client,$WINDOW
	done
	mmsg dispatch focusid, client,$FOCUSED
}

#while true; do
update_size
sleep 1
#done


	

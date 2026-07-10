#!/bin/bash

ACTIVEMON=$(mmsg get all-monitors | jq '.monitors[] | select(.active == true) | .name' -r)
ACTIVETAG=$(mmsg get tags DP-1 | jq '.tags[] | select(.is_active == true) | .index' -r)
ACTIVEWINDOWS=$(mmsg get all-clients | jq -r --arg ACTIVETAG "$ACTIVETAG" --arg ACTIVEMON "$ACTIVEMON" '.clients[] | select(.tags[] == ($ACTIVETAG | tonumber) and .monitor == $ACTIVEMON) | .id')

focusedwindow=$(mmsg get focusing-client | jq '.id')

EXPHEIGHT=998
EXPWIDTH=1912
EXPX=1924
EXPY=78

DELAY=0.00

# add to X for monitor

if [ "$ACTIVEMON" == "DP-2" ]; then
    EXPX=4
elif [ "$ACTIVEMON" == "HDMI-A-1" ]; then
    EXPX=1924
elif [ "$ACTIVEMON" == "DP-3" ]; then
    EXPX=3844
fi

HTOTAL=$(($EXPHEIGHT + $EXPY))
VTOTAL=$(($EXPWIDTH + EXPX))


while true; do
    mmsg dispatch focusid client,$focusedwindow
    CURRENTHEIGHT=$(mmsg get client $focusedwindow | jq '.height')
    CURRENTY=$(mmsg get client $focusedwindow | jq '.y')

    HEIGHTSUM=$(($CURRENTHEIGHT + $CURRENTY))

    echo "downmerging with current height $CURRENTHEIGHT, current Y $CURRENTY and heightsum $HEIGHTSUM vs $HTOTAL"
    # downmerge
    if [[ "$HEIGHTSUM" != "$HTOTAL" ]]; then
        echo "downmerge run"
        mmsg dispatch focusid client,$focusedwindow
        mmsg dispatch focusdir,down
        mmsg dispatch groupjoin,up
        mmsg dispatch focusid client,$focusedwindow
    else
        echo "downmerge skipped - no windows below"
    fi
    sleep $DELAY
    CURRENTHEIGHT=$(mmsg get client $focusedwindow | jq '.height')
    CURRENTY=$(mmsg get client $focusedwindow | jq '.y')
    
    echo "upmerging with current height $CURRENTHEIGHT, current Y $CURRENTY vs $EXPY"
    # upmerge
    if [[ "$CURRENTY" != "$EXPY" ]]; then
        echo "upmerge run"
        mmsg dispatch focusid client,$focusedwindow
        mmsg dispatch focusdir,up
        mmsg dispatch groupjoin,down
        mmsg dispatch focusid client,$focusedwindow
    else
        echo "upmerge skipped - no windows above"
    
    fi

    sleep $DELAY
    CURRENTWIDTH=$(mmsg get client $focusedwindow | jq '.width')
    CURRENTX=$(mmsg get client $focusedwindow | jq '.x')

    echo "leftmerging with current width $CURRENTWIDTH, current X $CURRENTX vs $EXPX"
    # leftmerge
    if [[ "$CURRENTX" != "$EXPX" ]]; then
        echo "leftmerge run"
        mmsg dispatch focusid client,$focusedwindow
        mmsg dispatch focusdir,left
        mmsg dispatch groupjoin,right
        mmsg dispatch focusid client,$focusedwindow
    else
        echo "leftmerge skipped - no windows to the left"
    fi
    sleep $DELAY
    CURRENTWIDTH=$(mmsg get client $focusedwindow | jq '.width')
    CURRENTX=$(mmsg get client $focusedwindow | jq '.x')

    WIDTHSUM=$(($CURRENTWIDTH + $CURRENTX))
    
    echo "rightmerging with current width $CURRENTWIDTH, current X $CURRENTX and widthsum $WIDTHSUM vs $VTOTAL"
    #rightmerge
    if [[ "$WIDTHSUM" != "$VTOTAL" ]]; then
        echo "rightmerge run"
        mmsg dispatch focusid client,$focusedwindow
        mmsg dispatch focusdir,right
        mmsg dispatch groupjoin,left
        mmsg dispatch focusid client,$focusedwindow
    else
        echo "rightmerge skipped - no windows to the right"
    fi
    sleep $DELAY
    CURRENTHEIGHT=$(mmsg get client $focusedwindow | jq '.height')
    CURRENTY=$(mmsg get client $focusedwindow | jq '.y')
    CURRENTWIDTH=$(mmsg get client $focusedwindow | jq '.width')
    CURRENTX=$(mmsg get client $focusedwindow | jq '.x')
    echo "checking height: $CURRENTHEIGHT vs $EXPHEIGHT"
    echo "checking Y: $CURRENTY vs $EXPY"
    echo "checking width: $CURRENTWIDTH vs $EXPWIDTH"
    echo "checking X: $CURRENTX vs $EXPX"
    # check if correct size is achieved
    if [ "$CURRENTHEIGHT" == "$EXPHEIGHT" ] && [ "$CURRENTY" == "$EXPY" ] && [ "$CURRENTWIDTH" == "$EXPWIDTH" ] && [ "$CURRENTX" == "$EXPX" ]; then
        exit 0
    fi
    sleep $DELAY
done


#!/bin/bash

CONFDIR="$HOME/.config/mango"
echo "confdir is $CONFDIR"

app=$EDITOR

while $true; do
    selected=$(ls -1 $CONFDIR | fzf --layout=reverse --preview="bat $CONFDIR/{}")

    echo "selected is $selected"
	if [ "$selected" == "" ]; then
		exit 0
	fi
	
    STRING=$(cat $CONFDIR/$selected | fzf --layout 'reverse' --preview-window 'down:50%,wrap-word' --preview-label='alt+b - open documentation in browser' --preview-label-pos='top'  --bind 'alt-b:execute(~/.local/SDG-MANGO-CONF/browser.sh {})' --preview='~/.local/SDG-MANGO-CONF/checker.sh {}')
	
done

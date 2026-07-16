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
	$app $CONFDIR/$selected

	echo "opened $CONFDIR/$selected in $app"
done


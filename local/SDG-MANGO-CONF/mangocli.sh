#!/bin/bash

ARG="$1"

LOC=$HOME/.local/SDG-MANGO-CONF


case $ARG in
	view)
	$LOC/menu.sh
	;;
	edit)
	$LOC/mango-config.sh
	;;
	*)
	echo "[mangoconf help]"
	echo ""
	echo "mangoconf view - shows an interactive TUI viewer of your config with line-by-line parsing and explanations"
	echo ""
	echo "mangoconf edit - shows a menu to select a config file with previews, then opens that in an editor"
	echo ""
	echo "mangoconf help - shows this menu"
	echo ""
	;;
esac


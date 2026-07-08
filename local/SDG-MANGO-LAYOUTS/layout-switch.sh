#!/bin/bash

#mmsg dispatch togglefloating


SELECTED=$(cat ~/.local/SDG-MANGO-LAYOUTS/layouts.list | cut -d '|' -f 1 | fzf --layout=reverse)

CMD=$(cat ~/.local/SDG-MANGO-LAYOUTS/layouts.list | grep -e "$SELECTED" | cut -d '|' -f 2)

eval $CMD

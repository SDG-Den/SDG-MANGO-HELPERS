#!/bin/bash

echo "SDG-MANGO-HELPERS dependency check"
echo ""

check() {
    if command -v "$1" &>/dev/null; then
        echo "  [OK] $1 found at $(which $1)"
    else
        echo "  [MISSING] $1 not found"
    fi
}

check mmsg
check mango
check dms
check fzf
check bat
check jq
check micro

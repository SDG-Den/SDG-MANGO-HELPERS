#!/bin/bash


set-rgb() {

    local mode=$1
    ckb-next -m $mode
}



prev=""
mmsg watch keymode | jq --unbuffered -r '.keymode' | while IFS= read -r line; do
    if [ "$line" != "$prev" ]; then
        prev="$line"
        set-rgb $line
    fi
done

#!/bin/bash

DIR=$1

case $DIR in
    left)
    mmsg dispatch focusdir,left
    mmsg dispatch groupjoin,right
    ;;
    right)
    mmsg dispatch focusdir,right
    mmsg dispatch groupjoin,left
    ;;
    up)
    mmsg dispatch focusdir,up
    mmsg dispatch groupjoin,down
    ;;
    down)
    mmsg dispatch focusdir,down
    mmsg dispatch groupjoin,up
    ;;
esac
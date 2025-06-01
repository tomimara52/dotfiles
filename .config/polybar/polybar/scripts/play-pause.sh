#!/usr/bin/bash 

STATE=$(playerctl -p spotify status)
if [ $STATE == "Paused" ]; then
    if [ $1 == "change" ]; then
        playerctl -p spotify play
    fi
    echo ""
else
    if [ $1 == "change" ]; then
        playerctl -p spotify pause 
    fi
    echo ""
fi

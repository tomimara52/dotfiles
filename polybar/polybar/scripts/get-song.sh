#!/usr/bin/bash 

zscroll -l 24 -d 0.1 --scroll-padding " | " \
    --match-command "playerctl -p spotify status" \
    --match-text "Playing" "-b '  '" \
    --match-text "Paused" "-d 0.3 -b '   '" \
    --update-check true "playerctl -p spotify metadata --format '{{artist}} - {{title}}'" &

wait

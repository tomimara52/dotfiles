#!/usr/bin/bash

xbacklight -get
while true; do
    inotifywait -e modify /sys/class/backlight/intel_backlight/brightness > /dev/null 2>&1
    xbacklight -get
done

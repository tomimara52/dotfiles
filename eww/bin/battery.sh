#!/usr/bin/bash

state=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state | cut -d: -f 2)
capacity=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | cut -d: -f 2 | cut -d % -f 1 | xargs)

if [[ $state =~ "discharging" ]]; then
    if (( $capacity <= 33 )); then
        echo 󱊡
    else 
        if (( $capacity <= 66 )); then
            echo 󱊢
        else
            echo 󱊣
        fi
    fi
else
    if (( $capacity <= 33 )); then
        echo 󱊤
    else 
        if (( $capacity <= 66 )); then
            echo 󱊥
        else
            echo 󱊦
        fi
    fi
fi

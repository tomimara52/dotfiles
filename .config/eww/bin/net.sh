#!/usr/bin/bash

wifi_interface="wlp0s20f3"
eth_interface="enp2s0"

get_state() {
    nmcli d | grep ^$1 | tr -s " " | cut -d " " -f 3
}

if [[ $(get_state $eth_interface) =~ connected ]]; then
    echo "󰈀 Wired"
else
    if [[ $(get_state $wifi_interface) =~ disconnected ]]; then
        echo "󰤭 Disconnected"
    else
        essid=$(iwconfig $wifi_interface | grep ESSID | cut -d '"' -f 2)
        quality=$(iwconfig $wifi_interface | grep "Link Quality" | cut -d "=" -f 2 | cut -d "/" -f 1)
        max_quality=$(iwconfig $wifi_interface | grep "Link Quality" | cut -d "=" -f 2 | cut -d "/" -f 2 | cut -d " " -f 1)

        if [[ $(echo "$quality / $max_quality < 0.25" | bc -l) == 1 ]]; then
            echo "󰤟 $essid"
        elif [[ $(echo "$quality / $max_quality < 0.5" | bc -l) == 1 ]]; then
            echo "󰤢 $essid"
        elif [[ $(echo "$quality / $max_quality < 0.75" | bc -l) == 1 ]]; then
            echo "󰤥 $essid"
        else 
            echo "󰤨 $essid"
        fi

    fi
fi

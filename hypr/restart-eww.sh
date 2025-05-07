#!/usr/bin/bash

eww ping

if [[ $? == 1 ]]; then
    eww daemon
else
    eww close-all
fi

eww open statusbar

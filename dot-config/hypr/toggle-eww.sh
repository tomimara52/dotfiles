#!/usr/bin/bash

eww ping

if [[ $? == 1 ]]; then
    eww daemon
    eww open statusbar
else
    eww close-all
    eww kill
fi


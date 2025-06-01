#!/usr/bin/bash 

case $1 in
    "volume")
        amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
        pactl subscribe \
          | grep --line-buffered "Event 'change' on sink " \
          | while read -r evt; 
          do amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1;
        done
    ;;
    "muted")
        [[ $(amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 3) =~ on ]] && echo 'false' || echo 'true'
        pactl subscribe \
          | grep --line-buffered "Event 'change' on sink " \
          | while read -r evt; 
          do [[ $(amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 3) =~ on ]] && echo 'false' || echo 'true';
        done
    ;;
esac

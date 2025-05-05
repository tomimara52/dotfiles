#!/usr/bin/bash 

case $1 in
    "mic")
        amixer get Dmic0 | grep '%' | head -n 1 | cut -d '%' -f 1 | cut -d '[' -f 2
        pactl subscribe \
          | grep --line-buffered "Event 'change' on source " \
          | while read -r evt; 
          do amixer get Dmic0 | grep '%' | head -n 1 | cut -d '%' -f 1 | cut -d '[' -f 2;
        done
    ;;
    "muted")
        [[ $(amixer get Dmic0 | grep '%' | head -n 1 | cut -d '[' -f 4 | cut -d ']' -f 1) =~ on ]] && echo false || echo true
        pactl subscribe \
          | grep --line-buffered "Event 'change' on source " \
          | while read -r evt; 
          do [[ $(amixer get Dmic0 | grep '%' | head -n 1 | cut -d '[' -f 4 | cut -d ']' -f 1) =~ on ]] && echo false || echo true;
        done
    ;;
esac

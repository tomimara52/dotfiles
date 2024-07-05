#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

green="\[\033[38;5;10m\]"
red="\[\033[38;5;9m\]"
pink="\[\033[38;5;13m\]"
dark_green="\[\033[38;5;2m\]"
white="\[\033[38;5;7m\]"
on_error="\[\$([[ \$? != 0 ]] && echo \"-[${red}✗${pink}]\")\]"

PS1="${pink}┌╼[${green}\t${pink}]-[${green}\w${pink}]${on_error}\n${pink}└╼[${green}\u${dark_green}@${green}\h${pink}]${dark_green}\$${white} " 

PATH="$PATH:/home/tomi/.local/bin:/home/tomi/.ghcup/bin"

alias snake="python3 ~/Documents/codes/console-snake/main.py"
alias minesweeper="python3 ~/Documents/codes/console-minesweeper/main.py"
alias emacs="emacsclient -nc -s instance1"
alias emacst="emacsclient -t -s instance1"
alias sensors="sensors && echo nvidia-temp && nvidia-settings -q gpucoretemp -t 2>/dev/null"


#[ -f "/home/tomi/.ghcup/env" ] && source "/home/tomi/.ghcup/env" # ghcup-env

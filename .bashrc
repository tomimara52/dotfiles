#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '

green="\[\033[38;5;10m\]"
red="\[\033[38;5;9m\]"
pink="\[\033[38;5;13m\]"
dark_green="\[\033[38;5;2m\]"
white="\[\033[38;5;7m\]"
on_error="\[\$([[ \$? != 0 ]] && echo \"-[${red}✗${pink}]\")\]"

PS1="${pink}┌╼[${green}\t${pink}]-[${green}\w${pink}]${on_error}\n${pink}└╼[${green}\u${dark_green}@${green}\h${pink}]${dark_green}\$${white} " 

PATH="$PATH:/home/tomi/.local/bin:/home/tomi/.ghcup/bin"

#alias bhaskara="~/Documents/codes/bhaskara/main"
alias bhaskara="~/Documents/codes/bhaskara-haskell/bhaskara"
alias snake="python3 ~/Documents/codes/console-snake/main.py"
alias minesweeper="python3 ~/Documents/codes/console-minesweeper/main.py"
#alias fvim='nvim "$(fzf)"'
#alias pong="~/Documents/codes/pong/dist-newstyle/build/x86_64-linux/ghc-8.10.7/pong-0.1.0.0/x/pong/build/pong/pong"
alias emacs="emacsclient -nc -s instance1"
alias emacst="emacsclient -t -s instance1"
alias compile="gcc -Wall -Wextra -Werror -pedantic" 
alias sensors="sensors && echo nvidia-temp && nvidia-settings -q gpucoretemp -t 2>/dev/null"

#eval "$(starship init bash)"

#[ -f "/home/tomi/.ghcup/env" ] && source "/home/tomi/.ghcup/env" # ghcup-env

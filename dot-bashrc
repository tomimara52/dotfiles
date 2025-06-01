#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto --hyperlink=auto'

export VIRTUAL_ENV_DISABLE_PROMPT=1

green="\[\033[38;5;10m\]"
red="\[\033[38;5;9m\]"
pink="\[\033[38;5;13m\]"
dark_green="\[\033[38;5;2m\]"
white="\[\033[38;5;7m\]"
on_error="\[\$([[ \$? != 0 ]] && echo \"${pink}-[${red}✗${pink}]\")\]"

function venv_prompt() {
    [[ -n $VIRTUAL_ENV ]] && echo "${pink}-[${green}venv:${dark_green}${VIRTUAL_ENV##*/}${pink}]"
}

function git_prompt() {
    branch=$(git branch --show-current 2>/dev/null)
    [[ $? == 0 ]] && echo "${pink}-[${green}branch:${dark_green}$branch${pink}]"
}

function create_ps1() {
    PS1="${pink}┌╼[${green}\t${pink}]-[${green}\w${pink}]$(venv_prompt)$(git_prompt)${on_error}\n${pink}└╼[${green}\u${dark_green}@${green}\h${pink}]${dark_green}\$${white} " 
}

PROMPT_COMMAND=create_ps1

PATH="$PATH:/home/tomi/.local/bin:/home/tomi/.ghcup/bin"

alias snake="python3 ~/Documents/codes/console-snake/main.py"
alias minesweeper="python3 ~/Documents/codes/console-minesweeper/main.py"
alias emacs="emacsclient -nc -s instance1"
alias emacst="emacsclient -t -s instance1"
alias sensors="sensors && echo nvidia-temp && nvidia-settings -q gpucoretemp -t 2>/dev/null"
alias sudoedit="sudo XDG_CONFIG_HOME=~/.config XDG_STATE_HOME=~/.local/state XDG_DATA_HOME=~/.local/share nvim -u ~/.config/nvim/init.lua"
alias nv=nvim
alias nvc="nvim -u NONE \
    -c \"set clipboard=unnamedplus\" \
    -c \"map q :q<CR>\" \
    -c \"autocmd VimEnter * normal G\" "

if [[ $TERM == "xterm-kitty" ]] then
    alias ssh="kitten ssh"
fi


export FZF_DEFAULT_OPTS='--tmux'
eval "$(fzf --bash)"

source /usr/share/git/completion/git-completion.bash

export EDITOR=nvim
export VISUAL=$EDITOR

#[ -f "/home/tomi/.ghcup/env" ] && source "/home/tomi/.ghcup/env" # ghcup-env


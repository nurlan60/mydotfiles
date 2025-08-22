#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias :q=exit
alias v=nvim

alias ld='eza -lD'
alias lf='eza -lF --color=always | grep -v /'
alias lh='eza -dl .* --group-directories-first'
alias ll='eza -al --group-directories-first'
alias ls='eza -alF --color=always --sort=size | grep -v /'
alias lt='eza -al --sort=modified'

alias mini="ssh mini"
alias mac="ssh mac"
alias asus="ssh asus"
alias deb="ssh debian"
alias len="ssh lenovo"
alias rpi="ssh rpi"

alias lg="lazygit"
alias gf='git fetch'
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gl="git pull"
alias gac="git add . && git commit -m" # + commit message
alias gst="git stash"
alias gsp="git stash; git pull"
alias gch="git checkout"
alias gcredential="git config credential.helper store"

alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

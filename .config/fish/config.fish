if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting ""
set -g fish_key_bindings fish_vi_key_bindings
set -gx EDITOR nvim

alias ls='eza --color=always --group-directories-first --icons'
alias ll='eza -la --icons --octal-permissions --group-directories-first'
alias v="nvim"
alias :q="exit"
alias lg="lazygit"
alias gac="git add . && git commit -m" # + commit message
alias gl="git pull"
alias gp="git push"

# Change Yazi's CWD to PWD on subshell exit
if [ -n "$YAZI_ID" ]
	trap 'ya emit cd "$PWD"' EXIT
end

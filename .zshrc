# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/nurlan/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall
######################################################

# Enable vi mode
# bindkey -v

# source antidote
source ~/.antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# common aliases
alias c="clear"
alias :q="exit"
alias cd..="cd .."
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'

alias v='$EDITOR'
alias vim='$EDITOR'
alias mc="mc -u"

# -----------------------------------------------------
# Ssh
# -----------------------------------------------------
alias mini="ssh mini"
alias mac="ssh mac"
alias asus="ssh asus"
alias deb="ssh debian"

# -----------------------------------------------------
# Fastfetch
# -----------------------------------------------------
alias nf='fastfetch'
alias pf='fastfetch'
alias ff='fastfetch'

# -----------------------------------------------------
# Git
# -----------------------------------------------------
alias lg="lazygit"
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gst="git stash"
alias gsp="git stash; git pull"
alias gcheck="git checkout"
alias gcredential="git config credential.helper store"

# specific
source ~/.aliases

# key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# zoxide
eval "$(zoxide init zsh)"

# Set up fzf key bindings and fuzzy completion
# source <(fzf --zsh)
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')

# Use fd instead of the default find
export FZF_DEFAULT_COMMAND='fd --type f'
_fzf_compgen_path() {
fd --type f --hidden --follow --exclude .git . "$1"
}
_fzf_compgen_dir() {
fd --type d . "$1"
}

# nnn
n ()
{
    # Block nesting of nnn in subshells
    if [[ "${NNNLVL:-0}" -ge 1 ]]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The backslash allows one to alias n to nnn if desired without making an
    # infinitely recursive alias
    \nnn -u "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# yazi
function y() {
  # Block nesting of yazi in subshells
  if [ -n "$YAZI_LEVEL" ]; then
    echo "yazi is already running"
    return
  fi

  # Change the current working directory when exiting Yazi 
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Change Yazi's CWD to PWD on subshell exit
if [[ -n "$YAZI_ID" ]]; then
	function _yazi_cd() {
		ya pub dds-cd --str "$PWD"
	}
	add-zsh-hook zshexit _yazi_cd
fi

# oh-my-posh
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/powerlevel10k_rainbow.omp.json)"
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/my.omp.json)"

# -----------------------------------------------------
# Fastfetch
# -----------------------------------------------------
if [[ $SHLVL == 1 ]]; then
    fastfetch --config examples/13
fi

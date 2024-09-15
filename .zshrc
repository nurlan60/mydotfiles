# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
bindkey -v

# source antidote
source ~/.antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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
function yy() {
  # Block nesting of yazi in subshells
  if [ -n "$YAZI_LEVEL" ]; then
    echo "yazi is already running"
    return
  fi

  # Change the current working directory when exiting Yazi 
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp" > /dev/null
}

# common aliases
alias cd..="cd .."
alias ll="eza -alh"
alias ls="eza"
alias tree="eza --tree"
alias :q="exit"
alias mc="mc -u"
alias lg="lazygit"
alias mini="ssh mini"
alias mac="ssh mac"
alias asus="ssh asus"
alias deb="ssh debian"
alias gp="git pull"

# specific
source ~/.aliases

# key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# zoxide
eval "$(zoxide init zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Use fd instead of the default find
export FZF_DEFAULT_COMMAND='fd --type f'
_fzf_compgen_path() {
fd --type f --hidden --follow --exclude .git . "$1"
}
_fzf_compgen_dir() {
fd --type d . "$1"
}

source "${HOME}/.iterm2_shell_integration.zsh"

# Change Yazi's CWD to PWD on subshell exit
if [[ -n "$YAZI_ID" ]]; then
	function _yazi_cd() {
		ya pub dds-cd --str "$PWD"
	}
	add-zsh-hook zshexit _yazi_cd
fi


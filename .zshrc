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
autoload -U add-zsh-hook

# aliases
alias v="nvim"
alias mc="SHELL=/bin/bash mc"
alias :q="exit"
alias keys="glow ~/.config/ghostty/ghostty-shortcuts.md -p"

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

# nnn config
export NNN_FIFO=/tmp/nnn.fifo
export NNN_COLORS='4321'
export NNN_PLUG='z:autojump;u:umounttree;i:-!viewer.sh "$nnn"'
export NNN_SSHFS='sshfs -o follow_symlinks'

# nnn start
n ()
{
    # Block nesting of nnn in subshells
    if [[ "${NNNLVL:-0}" -ge 1 ]]; then
        # echo "nnn is already running"
        exit
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

# yazi start
function y() {
  # Block nesting of yazi in subshells
  if [ -n "$YAZI_LEVEL" ]; then
    # echo "yazi is already running"
    exit
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
		ya emit cd "$PWD"
	}
	add-zsh-hook zshexit _yazi_cd
fi

# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

if [[ $(uname) == "Darwin" ]]; then
    alias python="/opt/homebrew/bin/python3"
    alias pip="/opt/homebrew/bin/pip3"
    
    PATH="${PATH}:/Users/nurlan/.local/bin:/Users/nurlan/.juliaup/bin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    
    # Homebrew config
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # oh-my-posh
    eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/my.omp.json)"

    # source antidote
    source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
    
    # Rust setup
    . "$HOME/.cargo/env"
else
    alias texlive='sh -c "xhost +si:localuser:root && sudo /usr/local/texlive/2025/bin/x86_64-linux/tlmgr --gui && xhost -si:localuser:root"'
    
    PATH="${PATH}:/usr/lib/ccache/bin/:/home/nurlan/.local/bin:/usr/local/texlive/2025/bin/x86_64-linux"
    
    # oh-my-posh
    eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/my.omp.toml)"
    
    # source antidote
    source /usr/share/zsh-antidote/antidote.zsh

    # colorscheme for zsh
    source ~/.config/zshrc.d/dots-hyprland.zsh  
fi

export PATH

# fzf init after zsh-vi-mod
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')

# zoxide
eval "$(zoxide init zsh)"

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Fastfetch
if ! [[ (-v YAZI_LEVEL) || (-v NNNLVL) ]]; then
    fastfetch --config examples/13
fi

# auto-launch Hyprland
if [[ $(uname) == "Linux" ]]; then
    source ~/.config/zshrc.d/auto-Hypr.sh
fi

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

# source antidote
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# specific
eval "$(/opt/homebrew/bin/brew shellenv)"

PATH="${PATH}:/Users/nurlan/.local/bin:/Library/Frameworks/Python.framework/Versions/3.12/bin:/Users/nurlan/.juliaup/bin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH

# Rust setup
. "$HOME/.cargo/env"

source "${HOME}/.iterm2_shell_integration.zsh"

alias python="/opt/homebrew/bin/python3"
alias pip="/opt/homebrew/bin/pip3"

# oh-my-posh
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/powerlevel10k_rainbow.omp.json)"
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/my.omp.json)"

# -----------------------------------------------------
# Load single customization file (if exists)
# -----------------------------------------------------

if [ -f ~/.zshrc_custom ] ;then
    source ~/.zshrc_custom
fi

# -----------------------------------------------------
# Fastfetch
# -----------------------------------------------------
if [[ $SHLVL == 1 ]]; then
    fastfetch --config examples/13
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


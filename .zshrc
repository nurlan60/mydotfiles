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
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# specific
source ~/.aliases

# oh-my-posh
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/powerlevel10k_rainbow.omp.json)"
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/my.omp.json)"

source $(brew --prefix)/Cellar/fzf/$(fzf --version | cut -d ' ' -f 1)/shell/key-bindings.zsh

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

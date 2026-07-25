export COLORTERM=truecolor
export EDITOR=nvim
export PATH="/Users/nurlan/.local/bin:$PATH"

# Homebrew config
eval "$(/opt/homebrew/bin/brew shellenv)"

# source antidote
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh

# libarchive
export PKG_CONFIG_PATH="/opt/homebrew/opt/libarchive/lib/pkgconfig"

# nnn config
export NNN_FIFO=/tmp/nnn.fifo
export NNN_COLORS='4321'
export NNN_PLUG='z:autojump;u:umounttree;i:-!viewer.zsh "$nnn"'
export NNN_SSHFS='sshfs -o follow_symlinks'

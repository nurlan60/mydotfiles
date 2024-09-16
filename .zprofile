eval "$(/opt/homebrew/bin/brew shellenv)"

PATH="${PATH}:/Users/nurlan/.local/bin:/Library/Frameworks/Python.framework/Versions/3.12/bin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH

source "${HOME}/.iterm2_shell_integration.zsh"

# Rust setup
. "$HOME/.cargo/env"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/Users/nurlan/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<



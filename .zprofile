eval "$(/opt/homebrew/bin/brew shellenv)"

PATH="${PATH}:/Users/nurlan/.local/bin:/Library/Frameworks/Python.framework/Versions/3.12/bin:/Users/nurlan/.juliaup/bin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH

# Rust setup
. "$HOME/.cargo/env"

source "${HOME}/.iterm2_shell_integration.zsh"

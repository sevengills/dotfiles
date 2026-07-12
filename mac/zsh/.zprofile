eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# default programs
export EDITOR="nvim"
export BROWSER="firefox-developer-edition"
export CHROME="google-chrome-stable"
export BROWSER2="librewolf"
# export DISPLAY=:0 # useful for some scripts

# follow XDG base dir specification
# export XDG_CONFIG_HOME="$HOME/.config"
# export XDG_DATA_HOME="$HOME/.local/share"
# export XDG_CACHE_HOME="$HOME/.cache"
# export XDG_RUNTIME_DIR="$XDG_CONFIG_HOME"

export XDG_CONFIG_HOME="$HOME/.config"
# bootstrap .zshrc to ~/.config/zsh/.zshrc, any other zsh config files can also reside here
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export DOTDIR="$HOME/dotfiles"
export SHELF="$HOME/phone/kindlary"




set -x LANG en_US.UTF-8

source ~/.asdf/asdf.fish

fish_add_path /opt/homebrew/bin
fish_add_path "$HOME/.asdf/shims"
fish_add_path "$HOME/.asdf/bin"

# Aliases
alias vim="nvim"
alias python="python3"
alias gc="git commit -m"
alias gco="git checkout"

# Envs
export EDITOR="nvim"

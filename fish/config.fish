set -x LANG en_US.UTF-8

if status is-interactive
    # Commands to run in interactive sessions can go here
end

source ~/.asdf/asdf.fish

direnv hook fish | source

# Aliases
alias vim="nvim"
alias python="python3"
alias gc="git commit -m"
alias gco="git checkout"

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export DISABLE_SPRING=true
export PGUSER=postgres
export PGHOST=localhost
export PGPORT=5432
export PGPASSWORD=postgres

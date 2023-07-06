set -x LANG en_US.UTF-8

if status is-interactive
    # Commands to run in interactive sessions can go here
end

source /opt/homebrew/opt/asdf/libexec/asdf.fish

# Aliases
alias vim="nvim"
alias python="python3"
alias gc="git commit -m"
alias gco="git checkout"

source ~/.iterm2_shell_integration.fish
function iterm2_print_user_vars
  iterm2_set_user_var awsProfile $AWS_PROFILE

  # KUBECONTEXT=$(CTX=$(kubectl config current-context) 2> /dev/null;if [ $? -eq 0 ]; then echo $CTX;fi)
  set KUBECONTEXT $(awk '/^current-context:/{print $2;exit;}' <~/.kube/config)
  iterm2_set_user_var kubeContext $KUBECONTEXT
end

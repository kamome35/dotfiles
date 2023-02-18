# ~/.bash_aliases

# safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias g='git'
if type "kubectl" > /dev/null 2>&1; then
  alias k='kubectl'
  complete -o default -F __start_kubectl k
fi
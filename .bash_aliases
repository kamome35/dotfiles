# ~/.bash_aliases

has() { type "$1" > /dev/null 2>&1; }

# safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias g='git'
if has "kubectl"; then
  alias k='kubectl'
  complete -o default -F __start_kubectl k
fi

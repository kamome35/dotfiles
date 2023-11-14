# ~/.bashrc

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi
if command -v go >/dev/null; then
  PATH="$PATH:$(go env GOPATH)/bin"
fi

# Load the shell dotfiles, and then some:
for file in ~/.{bash_prompt,bash_aliases}; do
  [ -s "$file" ] && \. "$file";
done;

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 027

# bash history
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# デフォルトエディタをvscodeに設定
export EDITOR="code --wait"

# SSHエージェント設定
SSH_AGENT_FILE=$HOME/.ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  ssh-agent > $SSH_AGENT_FILE
fi
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval "$(<$SSH_AGENT_FILE)" > /dev/null
fi
if ! ssh-add -L > /dev/null; then
  ssh-add > /dev/null 2>&1
fi

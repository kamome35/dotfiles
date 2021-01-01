#!/bin/bash

# env
DOTREMOTE=https://github.com/kyoronet/dotfiles
DOTPATH=~/.dotfiles

# functions
die() { echo "$*" 1>&2 ; exit 1; }
has() { type "$1" > /dev/null 2>&1; }

# remote install
if [ -d "$DOTPATH" ]; then
    :
elif has "git"; then
    git clone --recursive $DOTREMOTE.git "$DOTPATH"
elif has "curl"; then
    echo $DOTREMOTE/archive/master.tar.gz
    curl -L "$DOTREMOTE/archive/master.tar.gz" | tar zxv
    mv -f dotfiles-master "$DOTPATH"
elif has "wget"; then
    wget -qO - "$DOTREMOTE/archive/master.tar.gz" | tar zxv
    mv -f dotfiles-master "$DOTPATH"
else
    die "git or curl or wget required"
fi

# local install
cd $DOTPATH
if [ $? -ne 0 ]; then
    die "not found: $DOTPATH"
fi
for file in .??*
do
    [ "$file" = ".git" ] && continue

    ln -snfv "$DOTPATH/$file" "$HOME/$file"
done

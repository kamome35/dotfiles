#!/bin/bash

# エラーハンドリング
set -e

# env
DOTPATH="${DOTPATH:-$HOME/.dotfiles}"
DOTREMOTE="${DOTREMOTE:-https://github.com/kamome35/dotfiles}"
BRANCH="${BRANCH:-main}"

# functions
die() { echo "$*" 1>&2 ; exit 1; }
has() { type "$1" > /dev/null 2>&1; }

# ヘッダー
echo "Starting installation..."

# dotfilesリポジトリのクローン
echo "Cloning dotfiles repository..."
if [ -d "$DOTPATH" ]; then
  :
elif has "git"; then
  git clone --single-branch --branch $BRANCH $DOTREMOTE.git "$DOTPATH"
elif has "curl"; then
  echo $DOTREMOTE/archive/${BRANCH}.tar.gz
  curl -L "$DOTREMOTE/archive/${BRANCH}.tar.gz" | tar zxv
  mv -f dotfiles-${BRANCH} "$DOTPATH"
elif has "wget"; then
  wget -qO - "$DOTREMOTE/archive/${BRANCH}.tar.gz" | tar zxv
  mv -f dotfiles-${BRANCH} "$DOTPATH"
else
  die "Error: git, curl, or wget is required to clone the repository."
fi

pushd "$DOTPATH" > /dev/null
if [ $? -ne 0 ]; then
  die "Error: not found '$DOTPATH'"
fi

# シンボリックリンクを作成
echo "Creating symbolic links for dotfiles..."
for file in .??*; do
  [ "$file" = ".git" ] && continue

  ln -snfv "$DOTPATH/$file" "$HOME/$file"
done

# シェル設定を再読み込み
echo "Reloading shell configuration..."
source ~/.bashrc

# 完了メッセージ
echo "Installation complete!"

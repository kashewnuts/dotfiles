#!/usr/bin/env bash

DOT_FILES=(
    .bash_profile        \
    .bashrc              \
    .git-completion.bash \
    .git-prompt.sh       \
    .gitconfig           \
    .gvimrc              \
    .hgrc                \
    .pythonstartup       \
    .vim                 \
    .vimrc               \
)

for file in ${DOT_FILES[@]}
do
  # Set Symbolic Link
  if [ -a $HOME/$file ]; then
    echo "Already exists file: $file"
  else
    ln -s $HOME/dotfiles/files/$file $HOME/$file
    echo "Put Symbolic Link: $file"
  fi
done

# Install neobundle.vim
if [ ! -e $HOME/.vim/neobundle.vim -a -x "`which git`" ]; then
  git clone https://github.com/Shougo/neobundle.vim ~/.vim/neobundle.vim
fi

# Set Symbolic Link .gitconfig.os
if [ -a $HOME/.gitconfig.os ]; then
  echo "Already exists file: $file"
else
  ln -s $HOME/dotfiles/.gitconfig.unix $HOME/.gitconfig.os
  echo "Put Symbolic Link: $file"
fi

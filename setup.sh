#!/usr/bin/env bash

DOT_FILES=(
    .bash_profile        \
    .bashrc              \
    .git-completion.bash \
    .git-prompt.sh       \
    .gitconfig           \
    .gitconfig.unix      \
    .gvimrc              \
    .pythonstartup       \
    .vim                 \
    .vimrc               \
)
GITCONFIGOS=.gitconfig.os

for file in ${DOT_FILES[@]}
do
  # Set Symbolic Link .gitconfig.os
  if [ $file = .gitconfig.unix ]; then
    if [ -a $HOME/${GITCONFIGOS} ]; then
      echo "Already exists file: ${GITCONFIGOS}"
    else
      ln -s $HOME/dotfiles/files/.gitconfig.unix $HOME/${GITCONFIGOS}
      echo "Put Symbolic Link: ${GITCONFIGOS}"
    fi
  else
    # Set Symbolic Link
    if [ -a $HOME/$file ]; then
      echo "Already exists file: $file"
    else
      ln -s $HOME/dotfiles/files/$file $HOME/$file
      echo "Put Symbolic Link: $file"
    fi
  fi
done

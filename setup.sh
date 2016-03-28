#!/usr/bin/env bash

DOT_FILES=(
    .bash_profile        \
    .bashrc              \
    .git-completion.bash \
    .git-prompt.sh       \
    .gitconfig           \
    .gitconfig.unix      \
    .pythonstartup       \
    .vim                 \
)
GITCONFIGOS=.gitconfig.os

for file in ${DOT_FILES[@]}
do
  if [ $file = .gitconfig.unix ]; then
    # Set Symbolic Link .gitconfig.os
    if [ -a $HOME/${GITCONFIGOS} ]; then
      echo "Already exists file: ${GITCONFIGOS}"
    else
      ln -s $HOME/dotfiles/files/$file $HOME/${GITCONFIGOS}
      echo "Put Symbolic Link: ${GITCONFIGOS}"
    fi
  else
    # Set Symbolic Link others
    if [ -a $HOME/$file ]; then
      echo "Already exists file: $file"
    else
      ln -s $HOME/dotfiles/files/$file $HOME/$file
      echo "Put Symbolic Link: $file"
    fi
  fi
done

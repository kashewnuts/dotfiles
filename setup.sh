#!/usr/bin/env bash

DOT_FILES=(
    .bash_profile        \
    .bashrc              \
    .git-completion.bash \
    .git-prompt.sh       \
    .gitconfig           \
    .hgrc                \
    .pythonstartup       \
)

VIM_FILES=(
    .vim                 \
    .vimrc               \
    .gvimrc              \
)

# For dot files
for file in ${DOT_FILES[@]}
do
  # Set Symbolic Link
  if [ -a $HOME/$file ]; then
    echo "Already exists file: $file"
  else
    ln -s $HOME/dotfiles/.config/$file $HOME/$file
    echo "Put Symbolic Link: $file"
  fi
done

# For Vim
for file in ${VIM_FILES[@]}
do
  # Set Symbolic Link
  if [ -a $HOME/$file ]; then
    echo "Already exists file: $file"
  else
    ln -s $HOME/dotfiles/.vim/$file $HOME/$file
    echo "Put Symbolic Link: $file"
  fi
done

# Set Symbolic Link .gitconfig.os
GITCONFIGOS=.gitconfig.os
if [ -a $HOME/${GITCONFIGOS} ]; then
  echo "Already exists file: ${GITCONFIGOS}"
else
  ln -s $HOME/dotfiles/.config/.gitconfig.unix $HOME/${GITCONFIGOS}
  echo "Put Symbolic Link: ${GITCONFIGOS}"
fi

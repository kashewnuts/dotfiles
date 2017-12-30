#!/usr/bin/env bash

# Const
DOT_FILES=(
  .ansible.cfg
  .bash_profile        \
  .bashrc              \
  .git-completion.bash \
  .git-prompt.sh       \
  .gitconfig           \
  .gitconfig.unix      \
  .gitignore           \
  .hgrc                \
  .inputrc             \
  .ptconfig.toml       \
  .pythonstartup       \
  .tigrc               \
  .tmux.conf           \
  .vim                 \
)

# Put Symbolic Link $1
put_symbolic_link() {
  if [ -a $HOME/$1 ]; then
    echo "Already exists file: $1"
  else
    ln -s $HOME/dotfiles/files/$file $HOME/$1
    echo "Put Symbolic Link: $1"
  fi
}

# Execute put_symbolic_link
for file in ${DOT_FILES[@]}; do
  if [ $file = .gitconfig.unix ]; then
    put_symbolic_link .gitconfig.os
  elif [ $file = .bashrc -a $HOME/$file ]; then
    put_symbolic_link .bash_aliases
  else
    put_symbolic_link $file
  fi
done

mkdir -p ~/.cache/tmp
mkdir -p ~/.config
CONFIG_FILES=(
  peco/config.json
  pep8
  flake8
)
for file in ${CONFIG_FILES[@]}; do
  if [ -a $HOME/.config/$file ]; then
    echo "Already exists file: $file"
  else
    ln -fs $HOME/dotfiles/.config/$file $HOME/.config/$file
    echo "Put Symbolic Link: $file"
  fi
done

DOT_FILES=(
    .vim              \
    .vimrc            \
    .gvimrc           \
    .hgrc             \
    .hgignore_global  \
    .gitconfig        \
    .gitignore_global \
    .bashrc           \
    .bash_profile     \
    .pythonstartup    \
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

  # Install neobundle.vim
  if [ ! -e $HOME/${DOT_FILES[0]}/neobundle.vim -a -x "`which git`" ]; then
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/neobundle.vim
  fi
done

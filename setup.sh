DOT_FILES=(
    .vim \
    .vimrc \
    .gvimrc \
    .hgrc \
    .hgignore_global \
    .gitconfig \
    .gitignore_global \
    .gitmodules \
    .bashrc \
    .bash_profile \
)

for file in ${DOT_FILES[@]}
do
  if [ -a $HOME/$file ]; then
    echo "既にファイルが存在します: $file"
  else
    ln -s $HOME/dotfiles/$file $HOME/$file
    echo "シンボリックリンクを貼りました: $file"
  fi
done

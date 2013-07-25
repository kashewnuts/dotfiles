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
  # シンボリックリンク設定
  if [ -a $HOME/$file ]; then
    echo "既にファイルが存在します: $file"
  else
    ln -s $HOME/dotfiles/$file $HOME/$file
    echo "シンボリックリンクを貼りました: $file"
  fi

  # neobundle.vim をインストールする
  if [ ! -e $HOME/${DOT_FILES[0]}/neobundle.vim -a -x "`which git`" ]; then
      git clone https://github.com/Shougo/neobundle.vim ~/.vim/neobundle.vim
  fi
done

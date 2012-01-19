"Vim戦闘力計測
function! Scouter(file, ...)
  let pat = '^\s*$\|^\s*"'
  let lines = readfile(a:file)
  if !a:0 || !a:1
    let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
  endif
  return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
\        echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)

"Vundle設定
set nocompatible
filetype off

if has('vim_starting')
    set runtimepath+=~/dotfiles/vimfiles/neobundle.vim/
    call neobundle#rc(expand('~/.bundle'))
endif

"githubにあるプラグイン
NeoBundle 'basyura/bitly.vim'
NeoBundle 'basyura/twibill.vim'
NeoBundle 'basyura/TweetVim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'tyru/open-browser.vim'
"Bundle 'mrtazz/simplenote.vim'

filetype plugin indent on

set encoding=utf8 "デフォルトの文字コード
set expandtab "タブをスペースに展開する(noexpandtab:展開しない)
set number " 行番号を非表示 (nonumber:非表示)
set tabstop=4 " タブの画面上での幅
set softtabstop=4 "ファイル内の  が対応する空白の数
set shiftwidth=4 "シフト移動幅
set textwidth=80 "桁数の制限
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
set smartindent "新しい行を作ったときに高度な自動インデントを行う
set directory=$HOME/vimbackup "スワップファイル用のディレクトリ
set showmatch "閉じ括弧が入力されたとき、対応する括弧を表示する
set backupdir=$HOME/vimbackup "バックアップファイルを作るディレクトリ

autocmd BufWritePre * :%s/\s\+$//ge " 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\t/  /ge " 保存時にtabをスペースに変換する

let g:neocomplcache_enable_at_startup = 1 "neocomplecacheを有効化

let g:quickrun_config={'*': {'split': ''}} " 横分割をするようにする
" 横分割時は下へ､ 縦分割時は右へ新しいウィンドウが開くようにする
set splitbelow
set splitright

set ambiwidth=double "文脈依存の文字幅を正常に表示する

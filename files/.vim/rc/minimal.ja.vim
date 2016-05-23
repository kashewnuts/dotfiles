if !1 | finish | endif            " vim-tiny または vim-small だった場合、以下の設定を読み込まない。
if &compatible | set nocompatible | endif " vi互換の動作を無効にし、Vimのデフォルト設定にする。

set encoding=utf-8                " 文字エンコーディングを設定する。
set fileformats=unix,dos,mac      " 改行 (<EOL>) の種類を指定する。
scriptencoding utf-8              " スクリプトで使われている文字コードを宣言する。

set guioptions=Mc                                 " 不要なメニュー表示をしない
set noerrorbells novisualbell t_vb=               " ビープ音を消す
set noswapfile nobackup nowritebackup noundofile  " バックアップを作成しない

set ambiwidth=double              " 全角文字を使えるようにする
set backspace=indent,eol,start    " バックスペースで各種消せるようにする
set clipboard=unnamed,autoselect  " OSのクリップボードを使う
set history=1000                  " 最近入力されたコマンドの履歴を表示する。
set list listchars=tab:>-,trail:-,extends:>,precedes:<  " 不可視文字を表示
set matchpairs& matchpairs+=<:>   " 対応括弧に<と>のペアを追加
set number                        " 行番号を表示する。
set showmatch matchtime=1         " 対応括弧をハイライト表示する

set autoindent                    " smartindentを使う時はONに設定する。
set smartindent                   " 高度な自動インデントを行う。
set copyindent                    " 新規行を自動インデントする時、既存行のインデント構造をコピー

set tabstop=4                     " タブ文字幅が画面上の見た目で何文字分であるか指定
set softtabstop=4                 " タブを押した時、挿入される空白の量
set expandtab                     " タブを挿入する時、代わりに適切な数の空白を使う。
set shiftwidth=4                  " 自動インデントの幅が画面上の見た目で何文字分であるか指定
set smarttab                      " タブを打ち込むと、'shiftwidth' の数だけ空白が挿入される。

set hlsearch                      " 検索結果をハイライト表示
set incsearch                     " インクリメンタルサーチを行う
set ignorecase                    " 検索パターンにおいて大文字と小文字を区別しない。
set smartcase                     " 検索パターンが大文字を含んでいたらオプション 'ignorecase' を上書きする。

set cmdheight=2                   " コマンドラインの行数を設定する。
set wildmenu wildmode=list:full   " コマンドライン補完
set display=lastline              " ウィンドウの最後の行ができる限りまで表示
set laststatus=2                  " 常にステータス行を表示する
" ステータス行の表示内容を設定する。
set statusline=%F%m%r%h%w\%=\[%{&ff}]\[%{strlen(&fenc)?&fenc:&enc}][%{strlen(&ft)?&ft:'no\ ft'}]\[%l-%c/%L]

filetype plugin indent on         " ファイルタイプ関連を有効にする
syntax on                         " シンタックスハイライトを有効にする
colorscheme desert                " カラースキーマ設定
set secure                        " vimrcの末尾に設定

"NeoBundle設定
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
NeoBundle 'Shougo/vimproc'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-guicolorscheme'
NeoBundle 'thinca/vim-ref'
NeoBundle 'Shougo/vinarise'
NeoBundle 'tyru/open-browser.vim'

filetype plugin indent on

syntax on "シンタックスハイライトを有効にする
set encoding=utf8 "デフォルトの文字コード
set ambiwidth=double "文脈依存の文字幅を正常に表示する
set expandtab "タブをスペースに展開する(noexpandtab:展開しない)
set number " 行番号を非表示 (nonumber:非表示)
set tabstop=4 " タブの画面上での幅
set softtabstop=4 "ファイル内の  が対応する空白の数
set shiftwidth=4 "シフト移動幅
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
set smartindent "新しい行を作ったときに高度な自動インデントを行う
set directory=$HOME/vimbackup "スワップファイル用のディレクトリ
set showmatch "閉じ括弧が入力されたとき、対応する括弧を表示する
set backupdir=$HOME/vimbackup "バックアップファイルを作るディレクトリ
set imdisable "挿入モードから抜ける際、入る際にIMEがオフになる

autocmd BufWritePre * :%s/\s\+$//ge " 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\t/  /ge " 保存時にtabをスペースに変換する

" 全角スペースの定義
hi ZenkakuSpace gui=underline guibg=DarkBlue cterm=underline ctermfg=LightBlue
match ZenkakuSpace /　/       " 全角スペースの色を変更

"ウィンドウ分割時にウィンドウサイズを調節する設定です。Shiftキー＋矢印キー。
nnoremap <silent> <S-Left>  :5wincmd <<CR>
nnoremap <silent> <S-Right> :5wincmd ><CR>
nnoremap <silent> <S-Up>    :5wincmd -<CR>
nnoremap <silent> <S-Down>  :5wincmd +<CR>

"検索結果に移動したとき、その位置を画面の中央にします。
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" 新しく作った行の最初の文字が '#' のとき、インデントを解除しない
autocmd FileType python :inoremap # X#
autocmd FileType python :set textwidth=80 "桁数の制限

" 1 ページあたりのツイート取得件数
let g:tweetvim_tweet_per_page = 50
" タイムラインにリツイートを含める
let g:tweetvim_include_rts    = 1
" ツイート時間の表示・非表示設定 (少しでも表示時間を速くしたい場合)
let g:tweetvim_display_time   = 1

let g:neocomplcache_enable_at_startup = 1 "neocomplecacheを有効化

let g:quickrun_config={'*': {'split': ''}} " 横分割をするようにする
" 横分割時は下へ､ 縦分割時は右へ新しいウィンドウが開くようにする
set splitbelow
set splitright

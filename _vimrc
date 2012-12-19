"NeoBundle設定
set nocompatible
filetype off

if has('vim_starting')
    set runtimepath+=~/dotfiles/vimfiles/neobundle.vim/
    call neobundle#rc(expand('~/.bundle'))
endif

"githubにあるプラグイン
"NeoBundle 'basyura/bitly.vim'
"NeoBundle 'basyura/twibill.vim'
"NeoBundle 'basyura/TweetVim'
"NeoBundle 'h1mesuke/unite-outline'
"NeoBundle 'mattn/webapi-vim'
"NeoBundle 'osyo-manga/neocomplcache-clang_complete'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimproc'
NeoBundle 'thinca/vim-quickrun'
"NeoBundle 'thinca/vim-guicolorscheme'
"NeoBundle 'thinca/vim-ref'
NeoBundle 'Shougo/vinarise'
"NeoBundle 'tyru/open-browser.vim'
"NeoBundle 'Rip-Rip/clang_complete'
"NeoBundle 'vim-scripts/c.vim'

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
"autocmd BufWritePre * :%s/\t/  /ge " 保存時にtabをスペースに変換する

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

" pair close checker.
" from othree vimrc ( http://github.com/othree/rc/blob/master/osx/.vimrc )
function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

" 新しく作った行の最初の文字が '#' のとき、インデントを解除しない
autocmd FileType python :inoremap # X#
autocmd FileType python :set textwidth=80 "桁数の制限
autocmd FileType rst :set textwidth=90 "桁数の制限(100だと文字が小さい)

" 1 ページあたりのツイート取得件数
let g:tweetvim_tweet_per_page = 50
" タイムラインにリツイートを含める
let g:tweetvim_include_rts    = 1
" ツイート時間の表示・非表示設定 (少しでも表示時間を速くしたい場合)
let g:tweetvim_display_time   = 1

"let g:neocomplcache_enable_at_startup = 1 "neocomplecacheを有効化

let g:quickrun_config={'*': {'split': ''}} " 横分割をするようにする
" 横分割時は下へ､ 縦分割時は右へ新しいウィンドウが開くようにする
set splitbelow
set splitright

" neocomplcache-clang_complete が正しく動作するために必要な各プラグインの設定

" neocomplcache
let g:neocomplcache_force_overwrite_completefunc=1

" clang_complete
let g:clang_complete_auto=1

"autocmd BufRead /tmp/crontab.* :set nobackup nowritebackup
"

"---------- neocomplecache設定 ----------

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

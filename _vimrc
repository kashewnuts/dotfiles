"--------------------------------------------------
"NeoBundle設定
"--------------------------------------------------
set nocompatible                      " Be iMproved

if has('vim_starting')
    set runtimepath+=~/dotfiles/vimfiles/neobundle.vim/
endif

call neobundle#rc(expand('~/.bundle'))

NeoBundleFetch 'Shougo/neobundle.vim' " Let NeoBundle manage NeoBundle
NeoBundleLocal ~/.vim/bundle_manual   " pathogen互換機能

"--------------------------------------------------
"githubにあるプラグイン
"--------------------------------------------------

NeoBundleLazy 'mjbrownie/vim-htmldjango_omnicomplete', {
\   "autoload" : { "filetypes" : ["htmldjango"] }
\}
NeoBundleLazy 'jmcantrell/vim-virtualenv', {
\   "autoload" : { "filetypes" : ["python"] }
\}
NeoBundle 'Shougo/neocomplcache'
NeoBundleLazy "Shougo/unite.vim", {
\   'autoload' : {
\       'commands' : [ "Unite" ]
\   }
\}
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'cygwin'  : 'make -f make_cygwin.mak',
      \     'mac'     : 'make -f make_mac.mak',
      \     'unix'    : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundleLazy 'thinca/vim-quickrun'

"NeoBundleLazy 'osyo-manga/neocomplcache-clang_complete'
"NeoBundleLazy 'Shougo/vimshell'
"NeoBundleLazy 'thinca/vim-ref'
"NeoBundleLazy 'Shougo/vinarise'
"NeoBundleLazy 'Rip-Rip/clang_complete'
"NeoBundleLazy 'vim-scripts/c.vim'
"NeoBundleLazy 'tyru/open-browser.vim'
"
filetype plugin indent on             " Required!
NeoBundleCheck                        " Installation check.

"--------------------------------------------------
" common
"--------------------------------------------------
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
set showmatch "閉じ括弧が入力されたとき、対応する括弧を表示する
set imdisable "挿入モードから抜ける際、入る際にIMEがオフになる

"set directory=$HOME/vimbackup "スワップファイル用のディレクトリ
"set backupdir=$HOME/vimbackup "バックアップファイルを作るディレクトリ
set noswapfile
set nobackup
set nowritebackup
autocmd BufRead /tmp/crontab.* :set nobackup nowritebackup

autocmd BufWritePre * :%s/\s\+$//ge " 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\t/  /ge " 保存時にtabをスペースに変換する

"ウィンドウ分割時にウィンドウサイズを調節する設定です。Shiftキー＋矢印キー。
nnoremap <silent> <S-Left>  :5wincmd <<CR>
nnoremap <silent> <S-Right> :5wincmd ><CR>
nnoremap <silent> <S-Up>    :5wincmd -<CR>
nnoremap <silent> <S-Down>  :5wincmd +<CR>

"検索結果に移動したとき、その位置を画面の中央にする。
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

"" neocomplcache-clang_complete が正しく動作するために必要な各プラグインの設定

"" neocomplcache
"let g:neocomplcache_force_overwrite_completefunc=1

"" clang_complete
"let g:clang_complete_auto=1

" 新しく作った行の最初の文字が '#' のとき、インデントを解除しない
autocmd FileType python :inoremap # X#
autocmd FileType python :set textwidth=80 "桁数の制限
autocmd FileType rst :set textwidth=90 "桁数の制限(100だと文字が小さい)

"--------------------------------------------------
" pair close checker.
" from othree vimrc ( http://github.com/othree/rc/blob/master/osx/.vimrc )
"--------------------------------------------------
function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

"--------------------------------------------------
" IndentGuides設定
"--------------------------------------------------
let s:bundle = neobundle#get("vim-indent-guides")
function! s:bundle.hooks.on_source(bundle)
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_auto_colors = 0
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#121212 ctermbg=233
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#262626 ctermbg=235
endfunction
unlet s:bundle

"--------------------------------------------------
" jedi設定
"--------------------------------------------------
let s:bundle = neobundle#get("jedi-vim")
function! s:bundle.hooks.on_source(bundle)
    let g:jedi#auto_initialization = 1
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#rename_command = "<leader>R"
    let g:jedi#popup_on_dot = 1
    let g:jedi#show_function_definition = 0
    autocmd FileType python let b:did_ftplugin = 1
endfunction
unlet s:bundle

"--------------------------------------------------
" vim-htmldjango_omnicomplete設定
"--------------------------------------------------
let s:bundle = neobundle#get("vim-htmldjango_omnicomplete")
function! s:bundle.hooks.on_source(bundle)
    autocmd FileType htmldjango set omnifunc=htmldjangocomplete#CompleteDjango
    autocmd FileType htmldjango inoremap {% {% %}<left><left><left>
    autocmd FileType htmldjango inoremap {{ {{ }}<left><left><left>
endfunction
unlet s:bundle

"--------------------------------------------------
" quickrun設定
"--------------------------------------------------
let s:bundle = neobundle#get("vim-quickrun")
function! s:bundle.hooks.on_source(bundle)
    let g:quickrun_config={'*': {'split': ''}} " 横分割をするようにする
    " 横分割時は下へ､ 縦分割時は右へ新しいウィンドウが開くようにする
    set splitbelow
    set splitright
endfunction
unlet s:bundle

"--------------------------------------------------
"neocomplecache設定
"--------------------------------------------------

let s:bundle = neobundle#get("neocomplcache")
function! s:bundle.hooks.on_source(bundle)
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
endfunction
unlet s:bundle

" ==============================================================================
" Vim settings
"
" Maintainer   : Kashun YOSHIDA
" To use this, copy to your home directory.
" ==============================================================================

"--------------------------------------------------
" NeoBundle
"--------------------------------------------------
set nocompatible                      " Be iMproved
if has('vim_starting')
    set runtimepath+=~/dotfiles/.vim/neobundle.vim
endif
call neobundle#rc(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
" pathogen互換機能
NeoBundleLocal ~/.vim/bundle_manual

"--------------------------------------------------
" ShougoWare
"--------------------------------------------------
NeoBundle 'Shougo/vimproc', {
            \ 'build': {
            \   'windows'   : 'make -f make_mingw32.mak',
            \   'cygwin'    : 'make -f make_cygwin.mak',
            \   'mac'       : 'make -f make_mac.mak',
            \   'unix'      : 'make -f make_unix.mak',
            \ }}
if has('lua') && v:version >= 703 && has('patch885') || has('lua') && v:version >= 704
    NeoBundleLazy 'Shougo/neocomplete.vim', {
        \ 'autoload': {
        \   'insert': 1,
        \ }}
    " 2013-07-03 14:30 NeoComplCacheに合わせた
    let g:neocomplete#enable_at_startup = 1
    let s:bundle = neobundle#get("neocomplete.vim")
    function! s:bundle.hooks.on_source(bundle)
        " NeoCompleteEnable
        let g:acp_enableAtStartup = 0
        " Use smartcase.
        let g:neocomplete#enable_smart_case = 1
        " Set minimum syntax keyword length.
        let g:neocomplete#sources#syntax#min_keyword_length = 3
    endfunction
    unlet s:bundle
else
    NeoBundleLazy 'Shougo/neocomplcache.vim', {
        \ 'autoload': {
        \   'insert': 1,
        \ }}
    " 2013-07-03 14:30 原因不明だがNeoComplCacheEnableコマンドが見つからないので変更
    let g:neocomplcache_enable_at_startup = 1
    let s:bundle = neobundle#get("neocomplcache.vim")
    function! s:bundle.hooks.on_source(bundle)
        let g:acp_enableAtStartup = 0
        let g:neocomplcache_enable_smart_case = 1
    endfunction
    unlet s:bundle
endif
NeoBundleLazy 'Shougo/neosnippet.vim', {
            \ 'depends': ["honza/vim-snippets"],
            \ 'autoload': {
            \   'insert': 1,
            \ }
            \}
NeoBundleLazy 'Shougo/unite.vim', {
            \   'autoload' : {
            \       'commands' : [ "Unite" ]
            \   }
            \}
NeoBundleLazy 'Shougo/vimfiler', {
            \   'autoload' : {
            \       'commands' : [ "VimFiler" ]
            \   }
            \}
NeoBundleLazy 'Shougo/vimshell', {
            \   'autoload' : {
            \       'commands' : [ "VimShell" ]
            \   }
            \}

"--------------------------------------------------
" thinca Plugin
"--------------------------------------------------
NeoBundleLazy "thinca/vim-quickrun", {
            \ "autoload": {
            \       'commands' : [ "Quickrun" ] }
            \ }
NeoBundleLazy 'thinca/vim-scouter', {
            \   'autoload' : {
            \       'commands' : [ "Scouter" ]
            \   }
            \}
NeoBundle 'kashewnuts/vim-ft-rst_header'    " respect thinca/vim-ft-rst_header

"--------------------------------------------------
" Python Plugin
"--------------------------------------------------
NeoBundleLazy "lambdalisue/vim-django-support", {
            \ "autoload": {
            \   "filetypes": ["python", "python3", "djangohtml"] }
            \ }
NeoBundleLazy 'mjbrownie/vim-htmldjango_omnicomplete', {
            \ "autoload": {
            \   "filetypes": ["python", "python3", "djangohtml"] }
            \ }
NeoBundleLazy 'davidhalter/jedi-vim', {
            \   "autoload" : { "filetypes" : ["python", "python3", "djangohtml",
            \                                 "jinja", "htmljinja"]
            \                }
            \}
NeoBundleLazy 'jmcantrell/vim-virtualenv', {
            \   "autoload" : { "filetypes" : ["python", "python3", "djangohtml",
            \                                 "jinja", "htmljinja"]
            \                }
            \}
NeoBundleLazy 'kevinw/pyflakes-vim', {
            \   "autoload" : { "filetypes" : ["python", "python3", "djangohtml",
            \                                 "jinja", "htmljinja"]
            \                }
            \}
NeoBundle 'nathanaelkane/vim-indent-guides'

filetype plugin indent on             " Required!
NeoBundleCheck                        " Installation check.

"--------------------------------------------------
" common
"--------------------------------------------------
" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END
syntax on "シンタックスハイライトを有効にする
set encoding=utf8 "デフォルトの文字コード
set ambiwidth=double "文脈依存の文字幅を正常に表示する
set number " 行番号を非表示 (nonumber:非表示)
set shiftwidth=4 "シフト移動幅
set smartindent "新しい行を作ったときに高度な自動インデントを行う
set showmatch "閉じ括弧が入力されたとき、対応する括弧を表示する
set imdisable "挿入モードから抜ける際、入る際にIMEがオフになる

" OSのクリップボードを使用する
set clipboard+=unnamed
set clipboard+=autoselect

" バックアップファイルを生成しない
set noswapfile
set nobackup
set nowritebackup

"--------------------------------------------------
" tab
"--------------------------------------------------
""行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
set tabstop=4 " タブの画面上での幅
set softtabstop=4 "ファイル内の  が対応する空白の数
set expandtab "タブをスペースに展開する(noexpandtab:展開しない)
set list listchars=tab:>-,trail:_ " タブと行末の空白文字を可視化
" Makefile のみタブをスペースに展開しない
autocmd MyAutoCmd FileType make setlocal noexpandtab
"autocmd MyAutoCmd BufWritePre * :%s/\t/  /ge " 保存時にtabをスペースに変換する

autocmd MyAutoCmd BufWritePre * :%s/\s\+$//ge " 保存時に行末の空白を除去する
" 新しく作った行の最初の文字が '#' のとき、インデントを解除しない
autocmd MyAutoCmd FileType python :inoremap # X#
autocmd MyAutoCmd FileType python :set textwidth=80 "桁数の制限
autocmd MyAutoCmd FileType rst :set textwidth=90 "桁数の制限(100だと文字が小さい)

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

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=LightBlue guibg=DarkBlue
match ZenkakuSpace /　/

"--------------------------------------------------------------------------
" pair close checker.
" from othree vimrc ( http://github.com/othree/rc/blob/master/osx/.vimrc )
"--------------------------------------------------------------------------
function! s:ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

"--------------------------------------------------
" IndentGuides
"--------------------------------------------------
let s:bundle = neobundle#get("vim-indent-guides")
function! s:bundle.hooks.on_source(bundle)
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_auto_colors = 0
    autocmd MyAutoCmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#121212 ctermbg=233
    autocmd MyAutoCmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#262626 ctermbg=235
endfunction
unlet s:bundle

"--------------------------------------------------
" jedi
"--------------------------------------------------
let s:bundle = neobundle#get("jedi-vim")
function! s:bundle.hooks.on_source(bundle)
    let g:jedi#auto_initialization = 1
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#rename_command = "<leader>R"
    let g:jedi#popup_on_dot = 1
    let g:jedi#show_function_definition = 0
    autocmd MyAutoCmd FileType python let b:did_ftplugin = 1
endfunction
unlet s:bundle

"--------------------------------------------------
" vim-htmldjango_omnicomplete
"--------------------------------------------------
let s:bundle = neobundle#get("vim-htmldjango_omnicomplete")
function! s:bundle.hooks.on_source(bundle)
    autocmd MyAutoCmd FileType htmldjango set omnifunc=htmldjangocomplete#CompleteDjango
    autocmd MyAutoCmd FileType htmldjango inoremap {% {% %}<left><left><left>
    autocmd MyAutoCmd FileType htmldjango inoremap {{ {{ }}<left><left><left>
endfunction
unlet s:bundle

"--------------------------------------------------
" quickrun
"--------------------------------------------------
nmap <Leader>r <Plug>(quickrun)
let s:bundle = neobundle#get("vim-quickrun")
function! s:bundle.hooks.on_source(bundle)
    let g:quickrun_config={'*': {'split': ''}} " 横分割をするようにする
    " 横分割時は下へ､ 縦分割時は右へ新しいウィンドウが開くようにする
    set splitbelow
    set splitright
endfunction
unlet s:bundle


"--------------------------------------------------
" neosnippet
"--------------------------------------------------
let s:bundle = neobundle#get("neosnippet.vim")
function! s:bundle.hooks.on_source(bundle)
    " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)"
                \: pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)"
                \: "\<TAB>"

    " For snippet_complete marker.
    if has('conceal')
        set conceallevel=2 concealcursor=i
    endif

    " Enable snipMate compatibility feature.
    let g:neosnippet#enable_snipmate_compatibility = 1

    " Tell Neosnippet about the other snippets
    let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
endfunction
unlet s:bundle

"--------------------------------------------------
" VimFiler
"--------------------------------------------------
let s:bundle = neobundle#get("vimfiler")
function! s:bundle.hooks.on_source(bundle)
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_safe_mode_by_default = 0
endfunction
unlet s:bundle

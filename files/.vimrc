" ==============================================================================
" Vim settings
"
" Maintainer   : Kashun YOSHIDA
" To use this, copy to your home directory.
" ==============================================================================

" -------------------------------------------------
" Initialize
" -------------------------------------------------
set nocompatible                  " Be iMproved

" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

" -------------------------------------------------
" NeoBundle
" -------------------------------------------------
let s:noplugin = 0
let s:neobundledir = expand("~/.vim/neobundle.vim")
let s:bundledir = expand("~/.vim/bundle")

if !isdirectory(s:neobundledir) || v:version < 702
  " NeoBundleが存在しない、もしくはVimのバージョンが古い場合はプラグインを一切
  " 読み込まない
  let s:noplugin = 1

elseif isdirectory(s:neobundledir) && !isdirectory(s:bundledir)
  " Neobundleが存在し、プラグインがインストールされていない場合下準備を行う
  if has("vim_starting")
    execute "set runtimepath+=" . s:neobundledir
  endif
  call neobundle#rc(s:bundledir)

  " -------------------------------------------------
  " Shougo plugins
  " -------------------------------------------------
  " Let NeoBundle manage NeoBundle
  NeoBundleFetch "Shougo/neobundle.vim"

  NeoBundle "Shougo/unite.vim"
  NeoBundle "Shougo/vimproc", {
        \ "build": {
        \   "windows"   : "make -f make_mingw32.mak",
        \   "cygwin"    : "make -f make_cygwin.mak",
        \   "mac"       : "make -f make_mac.mak",
        \   "unix"      : "make -f make_unix.mak",
        \ }}

  filetype plugin indent on       " Required!
  NeoBundleCheck                  " Installation check.

else
  if has("vim_starting")
    execute "set runtimepath+=" . s:neobundledir
  endif
  call neobundle#rc(s:bundledir)

  " -------------------------------------------------
  " Shougo plugins
  " -------------------------------------------------
  " Let NeoBundle manage NeoBundle
  NeoBundleFetch "Shougo/neobundle.vim"

  NeoBundleLazy "Shougo/unite.vim", {
        \   "autoload" : { "commands" : [ "Unite" ] }
        \}

  NeoBundle "Shougo/vimproc", {
        \ "build": {
        \   "windows"   : "make -f make_mingw32.mak",
        \   "cygwin"    : "make -f make_cygwin.mak",
        \   "mac"       : "make -f make_mac.mak",
        \   "unix"      : "make -f make_unix.mak",
        \ }}

  if has("lua") && ((v:version >= 703 && has("patch885")) || v:version >= 704)
    NeoBundleLazy "Shougo/neocomplete.vim", {
        \ "autoload": { "insert": 1, }
        \ }
    " NeoComplCacheに合わせた
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
    NeoBundleLazy "Shougo/neocomplcache.vim", {
        \ "autoload": {"insert": 1, }
        \ }
    " 原因不明だがNeoComplCacheEnableコマンドが見つからないので変更
    let g:neocomplcache_enable_at_startup = 1
    let s:bundle = neobundle#get("neocomplcache.vim")
    function! s:bundle.hooks.on_source(bundle)
      let g:acp_enableAtStartup = 0
      let g:neocomplcache_enable_smart_case = 1
    endfunction
    unlet s:bundle
  endif

  NeoBundleLazy "Shougo/neosnippet.vim", {
        \   "depends": ["honza/vim-snippets"],
        \   "autoload": { "insert": 1, }
        \}
  let s:bundle = neobundle#get("neosnippet.vim")
  function! s:bundle.hooks.on_source(bundle)
    " Plugin key-mappings.
    imap <C-k>   <Plug>(neosnippet_expand_or_jump)
    smap <C-k>   <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>   <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
          \ "\<Plug>(neosnippet_expand_or_jump)"
          \: pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
          \ "\<Plug>(neosnippet_expand_or_jump)"
          \: "\<TAB>"

    " For snippet_complete marker.
    if has("conceal")
      set conceallevel=2 concealcursor=i
    endif

    " Enable snipMate compatibility feature.
    let g:neosnippet#enable_snipmate_compatibility = 1

    " Tell Neosnippet about the other snippets
    let g:neosnippet#snippets_directory=s:bundledir."/vim-snippets/snippets"
  endfunction
  unlet s:bundle

  NeoBundleLazy "Shougo/vimfiler", {
        \   "autoload" : { "commands" : [ "VimFiler" ] }
        \}
  let s:bundle = neobundle#get("vimfiler")
  function! s:bundle.hooks.on_source(bundle)
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_safe_mode_by_default = 0
  endfunction
  unlet s:bundle

  NeoBundleLazy "Shougo/vimshell", {
        \   "autoload" : { "commands" : [ "VimShell" ] }
        \}

  " -------------------------------------------------
  " thinca plugins
  " -------------------------------------------------
  NeoBundleLazy "thinca/vim-quickrun", {
        \   "autoload": { "commands" : [ "Quickrun" ] }
        \ }
  nmap <Leader>r <Plug>(quickrun)
  let s:bundle = neobundle#get("vim-quickrun")
  function! s:bundle.hooks.on_source(bundle)
    " 横分割をするようにする。
    " デフォルトでシェバンを無効にする。(Windows 環境での文字化けを防ぐため)
    let g:quickrun_config={"_": {"split": "", "hook/shebang/enable" : 0,}}
    " 横分割時は下へ､ 縦分割時は右へ新しいウィンドウが開くようにする
    set splitbelow splitright
  endfunction
  unlet s:bundle

  NeoBundleLazy "thinca/vim-scouter", {
        \   "autoload" :  { "commands" : [ "Scouter" ] }
        \}

  NeoBundle "kashewnuts/vim-ft-rst_header"    " respect thinca/vim-ft-rst_header

  " -------------------------------------------------
  " Python plugins
  " -------------------------------------------------
  NeoBundleLazy "davidhalter/jedi-vim", {
        \  "autoload" : {
        \    "insert" : 1,
        \    "filetypes" : ["python", "python3", "djangohtml", "jinja", "htmljinja"] }
        \}
  let s:bundle = neobundle#get("jedi-vim")
  function! s:bundle.hooks.on_source(bundle)
    let g:jedi#auto_initialization = 0
    let g:jedi#auto_vim_configuration = 1
    let g:jedi#rename_command = "<leader>R"
    let g:jedi#popup_on_dot = 1
    let g:jedi#show_call_signatures = 0
    let g:jedi#popup_select_first = 0
    autocmd MyAutoCmd FileType python let b:did_ftplugin = 1
  endfunction
  unlet s:bundle

  NeoBundleLazy "lambdalisue/vim-django-support", {
        \  "autoload": {
        \     "filetypes": ["python", "python3", "djangohtml"] }
        \ }

  NeoBundleLazy "jmcantrell/vim-virtualenv", {
        \   "autoload" : {
        \     "filetypes" : ["python", "python3", "djangohtml", "jinja", "htmljinja"] }
        \}

  NeoBundleLazy "kevinw/pyflakes-vim", {
        \   "autoload" : {
        \     "filetypes" : ["python", "python3", "djangohtml", "jinja", "htmljinja"] }
        \}

  NeoBundleLazy "nvie/vim-flake8", {
        \   "autoload" : {
        \     "filetypes" : ["python", "python3", "djangohtml", "jinja", "htmljinja"] }
        \}

  " -------------------------------------------------
  " Common plugins
  " -------------------------------------------------
  NeoBundle "tpope/vim-surround"

  NeoBundle "vim-scripts/Align"
  let s:bundle = neobundle#get("Align")
  function! s:bundle.hooks.on_source(bundle)
    let g:Align_xstrlen = 3      " for japanese string
    let g:DrChipTopLvlMenu = ''  " remove 'DrChip' menu
  endfunction
  unlet s:bundle

  filetype plugin indent on       " Required!
  NeoBundleCheck                  " Installation check.
endif

" -------------------------------------------------
" Common
" -------------------------------------------------
syntax on                         " シンタックスハイライトを有効にする
set encoding=utf8                 " デフォルトの文字コード
set number                        " 行番号を非表示 (nonumber:非表示)
set smartindent                   " 新しい行を作ったときに高度な自動インデントを行う
set clipboard+=unnamed,autoselect " OSのクリップボードを使用する
set showmatch                     " 閉じ括弧が入力されたとき、対応する括弧を表示する
set matchpairs& matchpairs+=<:>   " 対応括弧に '<' と '>' のペアを追加
set backspace=indent,eol,start    " バックスペースでなんでも消せるようにする
set tabstop=4                     " タブの画面上での幅
set softtabstop=4                 " ファイル内の  が対応する空白の数
set expandtab                     " タブをスペースに展開する(noexpandtab:展開しない)
set shiftwidth=4                  " シフト移動幅
set smarttab " 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデント
set noswapfile nobackup nowritebackup " バックアップファイルを生成しない

if (has("win16") || has("win32") || has("win64"))
  set list listchars=tab:>-,trail:-,extends:>,precedes:< " 不可視文字の可視化
else
  set imdisable                   " 挿入モードから抜ける際、入る際にIMEがオフになる
  set ambiwidth=double            " 文脈依存の文字幅を正常に表示する
  set list listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
endif

" 新しく作った行の最初の文字が '#' のとき、インデントを解除しない
autocmd MyAutoCmd FileType python inoremap # X#
autocmd MyAutoCmd FileType python set textwidth=80 " 桁数の制限
autocmd MyAutoCmd BufNewFile *.py 0r $HOME/.vim/template/python.txt
autocmd MyAutoCmd BufWritePost *.py call Flake8()

autocmd MyAutoCmd FileType cf set noexpandtab
autocmd MyAutoCmd FileType make set noexpandtab

" カーソル位置が動くと鬱陶しい
function! s:remove_dust()
  let cursor = getpos(".")
  %s/\s\+$//ge                    " 保存時に行末の空白を除去する
  %s/\t/  /ge                     " 保存時にtabを2スペースに変換する
  call setpos(".", cursor)
  unlet cursor
endfunction
autocmd MyAutoCmd BufWritePre *.py call <SID>remove_dust()
autocmd MyAutoCmd BufWritePre *.txt call <SID>remove_dust()
autocmd MyAutoCmd BufWritePre *.rst call <SID>remove_dust()

" ウィンドウ分割時にウィンドウサイズを調節する設定です。Shiftキー＋矢印キー。
nnoremap <silent> <S-Left>  :5wincmd <<CR>
nnoremap <silent> <S-Right> :5wincmd ><CR>
nnoremap <silent> <S-Up>    :5wincmd -<CR>
nnoremap <silent> <S-Down>  :5wincmd +<CR>

" 検索結果に移動したとき、その位置を画面の中央にする。
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" 指定文字コードで強制的にファイルを開く
command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! Utf8 edit ++enc=utf-8
command! Jis Iso2022jp
command! Sjis Cp932

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

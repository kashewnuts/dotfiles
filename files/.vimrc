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
" Plugins
" -------------------------------------------------
let s:noplugin = 0
let s:neobundledir = expand("~/.vim/neobundle.vim")
let s:bundledir = expand("~/.vim/bundle")

if !isdirectory(s:neobundledir) || v:version < 702
  let s:noplugin = 1

elseif isdirectory(s:neobundledir) && !isdirectory(s:bundledir)
  " If Neobundle is present and the plug-in is not installed,
  " I performed in preparation
  if has("vim_starting")
    execute "set runtimepath+=" . s:neobundledir
  endif
  call neobundle#rc(s:bundledir)

  " -------------------------------------------------
  " Shougo plugins
  " -------------------------------------------------
  NeoBundleFetch "Shougo/neobundle.vim"  " Let NeoBundle manage NeoBundle
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
  NeoBundleFetch "Shougo/neobundle.vim"  " Let NeoBundle manage NeoBundle
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
        \  "autoload": { "insert": 1, }
        \ }
    " Combined with NeoComplCache
    let g:neocomplete#enable_at_startup = 1
    let s:bundle = neobundle#get("neocomplete.vim")
    function! s:bundle.hooks.on_source(bundle)
      let g:acp_enableAtStartup = 0            " NeoCompleteEnable
      let g:neocomplete#enable_smart_case = 1  " Use smartcase.
      " Set minimum syntax keyword length.
      let g:neocomplete#sources#syntax#min_keyword_length = 3
      " jedi omni completion
      autocmd MyAutoCmd FileType python setlocal omnifunc=jedi#completions
      let g:jedi#auto_vim_configuration = 0
      if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
      endif
      let g:neocomplete#force_omni_input_patterns.python = '[^. \t]\.\w*'
      let g:neocomplete#force_omni_input_patterns.go = '[^. \t]\.\w*'
    endfunction
    unlet s:bundle

  else
    NeoBundleLazy "Shougo/neocomplcache.vim", {
        \  "autoload": {"insert": 1, }
        \ }
    " Cause is unknown, but NeoComplCacheEnable command is found, so change.
    let g:neocomplcache_enable_at_startup = 1
    let s:bundle = neobundle#get("neocomplcache.vim")
    function! s:bundle.hooks.on_source(bundle)
      let g:acp_enableAtStartup = 0
      let g:neocomplcache_enable_smart_case = 1
      " jedi omni completion
      autocmd MyAutoCmd FileType python setlocal omnifunc=jedi#completions
      let g:jedi#auto_vim_configuration = 0
      if !exists('g:neocomplcache_force_omni_patterns')
        let g:neocomplcache_force_omni_patterns = {}
      endif
      let g:neocomplcache_force_omni_patterns.python = '[^. \t]\.\w*'
    endfunction
    unlet s:bundle
  endif

  NeoBundleLazy "Shougo/neosnippet.vim", {
        \  "depends": ["honza/vim-snippets", "Shougo/neosnippet-snippets"],
        \  "autoload": { "insert": 1, }
        \ }
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
      \ "depends": ["Shougo/unite.vim"],
      \ "autoload": {
      \   "commands": ["VimFiler", "VimFilerTab", "VimFilerExplorer"],
      \ }}
  nnoremap <Leader>e :VimFilerExplorer<CR>
  " close vimfiler automatically when there are only vimfiler open
  autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
  let s:bundle = neobundle#get("vimfiler")
  function! s:bundle.hooks.on_source(bundle)
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_safe_mode_by_default = 0
  endfunction
  unlet s:bundle

  NeoBundleLazy "Shougo/vimshell", {
        \   "autoload" : { "commands" : [ "VimShell" ] }
        \ }

  " -------------------------------------------------
  " thinca plugins
  " -------------------------------------------------
  NeoBundleLazy "thinca/vim-quickrun", {
        \  "autoload": { "commands" : [ "Quickrun" ] }
        \ }
  nmap <Leader>r <Plug>(quickrun)
  let s:bundle = neobundle#get("vim-quickrun")
  function! s:bundle.hooks.on_source(bundle)
    " Open at the height of 10-digit buffer window by horizontal split at the bottom
    " Enable asynchronous processing
    " Disable the Sheban prevent garbled in a Windows environment
    let g:quickrun_config = {
    \  "_" : {
    \      "outputter/buffer/split" : ":botright 10sp",
    \      "runner" : "vimproc",
    \      "hook/shebang/enable" : 0,
    \  }
    \ }
  endfunction
  unlet s:bundle

  NeoBundleLazy "thinca/vim-scouter", {
        \  "autoload" :  { "commands" : [ "Scouter" ] }
        \ }

  NeoBundle "kashewnuts/vim-ft-rst_header"    " respect thinca/vim-ft-rst_header

  " -------------------------------------------------
  " Python plugins
  " -------------------------------------------------
  NeoBundleLazy "davidhalter/jedi-vim", {
        \  "autoload": {
        \    "insert" : 1,
        \    "filetypes" : ["python", "python3", "djangohtml", "jinja", "htmljinja"] }
        \ }

  let s:bundle = neobundle#get("jedi-vim")
  function! s:bundle.hooks.on_source(bundle)
    let g:jedi#auto_initialization = 0
    let g:jedi#rename_command = "<leader>R"
    let g:jedi#popup_on_dot = 1
    let g:jedi#show_call_signatures = 0
    let g:jedi#popup_select_first = 0
    autocmd MyAutoCmd FileType python let b:did_ftplugin = 1
  endfunction
  unlet s:bundle

  NeoBundleLazy "lambdalisue/vim-django-support", {
        \  "autoload": {
        \    "filetypes": ["python", "python3", "djangohtml"] }
        \ }

  NeoBundleLazy "jmcantrell/vim-virtualenv", {
        \  "autoload" : {
        \    "filetypes" : ["python", "python3", "djangohtml", "jinja", "htmljinja"] }
        \ }

  NeoBundleLazy "nvie/vim-flake8", {
        \  "autoload": {
        \    "filetypes" : ["python", "python3", "djangohtml", "jinja", "htmljinja"] }
        \ }

  " -------------------------------------------------
  "  Golang plugins
  " -------------------------------------------------
  NeoBundleLazy "nsf/gocode", {
        \  "autoload": { "filetypes" : ["go"] }
        \ }
  NeoBundleLazy "Blackrush/vim-gocode", {
        \  "autoload": { "filetypes" : ["go"] }
        \ }

  " -------------------------------------------------
  "  Editting support plugins
  " -------------------------------------------------
  NeoBundle "tpope/vim-surround"
  NeoBundle "vim-scripts/Align"
  let s:bundle = neobundle#get("Align")
  function! s:bundle.hooks.on_source(bundle)
    let g:Align_xstrlen = 3       " for japanese string
    let g:DrChipTopLvlMenu = ''   " remove 'DrChip' menu
  endfunction
  unlet s:bundle
  NeoBundleLazy "mrtazz/simplenote.vim", {
        \  "autoload" :  { "commands" : [ "Simplenote" ] }
        \ }

  filetype plugin indent on       " Required!
  NeoBundleCheck                  " Installation check.
endif

" -------------------------------------------------
" Common
" -------------------------------------------------
syntax on          " Enable syntax highlighting
set encoding=utf8  " Default character code
set number         " Show line number (nonumber: Hide)
set smartindent    " Advanced automatic indentation when you made the new line
set showmatch      " When the brackets is entered closed, to view the matching brackets
set tabstop=4      " Width on the screen of the tab
set softtabstop=4  " Number of spaces in the file space is the corresponding
set expandtab      " expand tabs to spaces (noexpandtab: do not expand)
set shiftwidth=4   " Shift move width
set smarttab       " Indent by the number of 'shiftwidth'.
set matchpairs& matchpairs+=<:>        " To support brackets add a pair of '<' and '>'
set backspace=indent,eol,start         " Can erase everything in the back space
set wildmenu wildmode=list:full        " Command-line completion
set clipboard+=unnamed,autoselect      " Use the OS clipboard
set noswapfile nobackup nowritebackup  " doesn't generate a backup file

if (has("win16") || has("win32") || has("win64"))
  set list listchars=tab:>-,trail:-,extends:>,precedes:< " visualize character
else
  set imdisable         " When you exit or enter, IME is turned off
  set list listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
endif

" When the '#' character in the first line of the newly created, it is not unindent
autocmd MyAutoCmd FileType python inoremap # X#
autocmd MyAutoCmd FileType python set textwidth=80 " Limit number of digits
autocmd MyAutoCmd BufNewFile *.py 0r $HOME/.vim/template/python.txt
autocmd MyAutoCmd BufWritePost *.py call Flake8()

autocmd MyAutoCmd FileType cf set noexpandtab
autocmd MyAutoCmd FileType make set noexpandtab
autocmd MyAutoCmd FileType go set noexpandtab

" Cheerless cursor position is moved
function! s:remove_dust()
  let cursor = getpos(".")
  %s/\s\+$//ge          " Remove trailing whitespace on save
  %s/\t/  /ge           " Converted to 2 whitespace tab when you save
  call setpos(".", cursor)
  unlet cursor
endfunction
autocmd MyAutoCmd BufWritePre *.py call <SID>remove_dust()
autocmd MyAutoCmd BufWritePre *.txt call <SID>remove_dust()
autocmd MyAutoCmd BufWritePre *.rst call <SID>remove_dust()

" Adjust the window size to the window time-division. Shift + arrow key.
nnoremap <silent> <S-Left>  :5wincmd <<CR>
nnoremap <silent> <S-Right> :5wincmd ><CR>
nnoremap <silent> <S-Up>    :5wincmd -<CR>
nnoremap <silent> <S-Down>  :5wincmd +<CR>

" When you move in the search results, and in the center of the screen that position.
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Open the file to force the specified character code.
command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! Utf8 edit ++enc=utf-8
command! Jis Iso2022jp
command! Sjis Cp932

" Turn off the highlight by pressing twice the ESC.
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" Escape automatically according to the situation question and backslash.
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" Even text wrapping movement by j or k, is modified to act naturally.
nnoremap j gj
nnoremap k gk

" -------------------------------------------------
" Automatic recognition of character code
" -------------------------------------------------
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " Check iconv are aware of eucJP-ms
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " Check iconv are aware of JISX0213
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " Construct fileencodings
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " dispose the constant
  unlet s:enc_euc
  unlet s:enc_jis
endif
" If don't include the Japanese, use the encoding to fileencoding
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd MyAutoCmd BufReadPost * call AU_ReCheck_FENC()
endif
" Automatic recognition of the line feed code
"set fileformats=unix,dos,mac
" Cursor position to prevent misalignment even if character of □ or ○
if exists('&ambiwidth')
  set ambiwidth=double
endif

" Golang settings
if $GOROOT != ''
  set rtp+=$GOROOT/misc/vim
  set completeopt=menu,preview
  if $GOPATH != ''
    " gocode
    exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
    " golint
    exe "set rtp+=".globpath($GOPATH, "src/github.com/golang/lint/misc/vim")
  endif
  " grep
  set grepprg=jvgrep
endif
autocmd MyAutoCmd BufWritePre *.go Fmt

" Simplenote settings
source ~/.simplenoterc

if has('undofile')
  set noundofile
endif

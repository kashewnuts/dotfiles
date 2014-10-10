" ==============================================================================
" Vim Configuration
"
" Author:   Kashun YOSHIDA
" Platform: Windows, Linux, MacOSX
" NOTE:     To use this, copy to your home directory.
" ==============================================================================

" Basic Settings {{{
" ------------------------------------------------------------------------------
if !1 | finish | endif  " skip if the live Vim is vim-tiny or vim-small
set nocompatible        " Be iMproved

" Encoding
set encoding=utf-8
scriptencoding utf-8

" release autogroup in MyAutoCmd
augroup MyAutoCmd
  au!
augroup END
" }}}

" Environment {{{
function! VimrcEnvironment()
  let env = {}
  let env.is_windows = has("win16") || has("win32") || has("win64")
  let env.is_darwin  = has("mac") || has("macunix") || has("gui_macvim")
  let env.is_ime     = has("multi byte_ime") || has("xim") || has("gui_macvim")
  return env
endfunction
let s:env = VimrcEnvironment()
" }}}

" Misc {{{
syntax on          " Enable syntax highlighting
set number         " Show line number (nonumber: Hide)
set smartindent    " Advanced automatic indentation when you made the new line
set showmatch      " The highlight matching brackets
set tabstop=4      " Width on the screen of the tab
set softtabstop=4  " Number of spaces in the file space is the corresponding
set expandtab      " noexpand tabs to spaces (expandtab: expand)
set shiftwidth=4   " Shift move width
set smarttab       " Indent by the number of 'shiftwidth'.
set history=1000   " history
set textwidth=0    " Disable new line to enter automatically
set ruler          " show the current row and column
set hlsearch       " highlight searches
set incsearch      " do incremental searching
set showmatch      " jump to matches when entering regexp
set ignorecase     " ignore case when searching
set smartcase      " no ignorecase if Uppercase char present
set matchpairs& matchpairs+=<:> " To support brackets add a pair of '<' and '>'
set backspace=indent,eol,start  " Can erase everything in the back space
set wildmenu wildmode=list:full " Command-line completion
set clipboard+=unnamed,autoselect      " Use the OS clipboard
set noswapfile nobackup nowritebackup  " doesn't generate a backup file
" disable annoying errorbells and visual bell completely
set noerrorbells novisualbell t_vb=
" Delete - characters that are displayed on the right side of the folding time
set fillchars=vert:\|
" }}}

" Visualize character {{{
if s:env.is_windows
  set list listchars=tab:>-,trail:-,extends:>,precedes:<
else
  set imdisable    " When you exit or enter, IME is turned off
  set list listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
endif
" }}}

" ColorScheme {{{
let s:colorscheme = (s:env.is_windows) ? 'louver' : 'adrian'
if !has('gui_running')
  execute printf('colorscheme %s', s:colorscheme)
else
  execute printf('au MyAutoCmd GUIEnter * colorscheme %s', s:colorscheme)
endif
" }}}

" FileType {{{

" ts   : tabstop
" sw   : shiftwidth
" sts  : softtabstop
" et   : expandtab
" noet : noexpandtab
" si   : smartindent
" cinw : cinwords
au MyAutoCmd FileType html       setl ts=2 sw=2 sts=2 et
au MyAutoCmd FileType htmldjango setl ts=2 sw=2 sts=2 et
au MyAutoCmd FileType javascript setl ts=2 sw=2 sts=2 et
au MyAutoCmd FileType ruby       setl ts=2 sw=2 sts=2 et
au MyAutoCmd FileType go         setl ts=4 sw=4 sts=4 noet
au MyAutoCmd FileType vim        setl ts=2 sw=2 sts=2 et
au MyAutoCmd FileType make       setl ts=4 sw=4 sts=4 noet
au MyAutoCmd FileType text       setl ts=4 sw=4 sts=4 et ft=rst
au MyAutoCmd FileType rst        setl ts=4 sw=4 sts=4 et
au MyAutoCmd FileType gitconfig  setl ts=4 sw=4 sts=4 noet
au MyAutoCmd FileType jsp setl ts=4 sw=4 sts=4 noet
au MyAutoCmd FileType java setl ts=4 sw=4 sts=4 noet
au MyAutoCmd FileType python     setl ts=4 sw=4 sts=4 et textwidth=80
" When the '#' character in the first line of the newly created,
" it isn't unindent
au MyAutoCmd FileType python inoremap # X#
au MyAutoCmd BufNewFile *.py 0r ~/.vim/template/python.txt
" }}}

" Cheerless cursor position is moved {{{
function! s:remove_dust()
  let cursor = getpos(".")
  %s/\s\+$//ge          " Remove trailing whitespace on save
  %s/\t/  /ge           " Converted to 2 whitespace tab when you save
  call setpos(".", cursor)
  unlet cursor
endfunction
au MyAutoCmd BufWritePre *.py call <SID>remove_dust()
au MyAutoCmd BufWritePre *.txt call <SID>remove_dust()
au MyAutoCmd BufWritePre *.rst call <SID>remove_dust()
" }}}

" Grep {{{
au MyAutoCmd QuickFixCmdPost *grep* cwindow
" }}}

" KeyMaping {{{
" Adjust the window size to the window time-division. Shift + arrow key.
nnoremap <silent> <S-Left>  :5wincmd <<CR>
nnoremap <silent> <S-Right> :5wincmd ><CR>
nnoremap <silent> <S-Up>    :5wincmd -<CR>
nnoremap <silent> <S-Down>  :5wincmd +<CR>

" When you move in the search results, 
" and in the center of the screen that position.
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Turn off the highlight by pressing twice the ESC.
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" Escape automatically according to the situation question and backslash.
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" Even text wrapping movement by j or k, is modified to act naturally.
nnoremap j gj
nnoremap k gk
" }}}

" Open the file to force the specified character code. {{{
command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! Utf8 edit ++enc=utf-8
command! Jis Iso2022jp
command! Sjis Cp932
" }}}

" Automatic recognition of character code {{{
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
if has('au')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  au MyAutoCmd BufReadPost * call AU_ReCheck_FENC()
endif
" Automatic recognition of the line feed code
"set fileformats=unix,mac,dos
" Cursor position to prevent misalignment even if character of □ or ○
if exists('&ambiwidth')
  set ambiwidth=double
endif " }}}

" Golang settings {{{
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
au MyAutoCmd BufWritePre *.go Fmt
" }}}

" Java settings {{{
" Syntax highlight
let g:java_highlight_all=1
let g:java_highlight_debug=1
let g:java_allow_cpp_keywords=1
let g:java_space_errors=1
let g:java_highlight_functions=1
" }}}

" Don't make *.un~ files {{{
if exists('&undofile')
  set noundofile
endif "}}}

" breakindent {{{
if v:version >= 704 && has('patch338')
  " https://github.com/vim-jp/issues/issues/114
  " http://ftp.vim.org/vim/patches/7.4/7.4.338
  set breakindent
endif "}}}

" Display full-width space {{{
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=LightGray guibg=DarkGray
endfunction

if has('syntax')
  augroup ZenkakuSpace
    au!
    au ColorScheme * call ZenkakuSpace()
    au VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
  augroup END
  call ZenkakuSpace()
endif
" }}}

" NeoBundle {{{
" ------------------------------------------------------------------------------
let s:noplugin     = 0
let s:neobundledir = expand("~/.vim/neobundle.vim")
let s:bundledir    = expand("~/.vim/bundle")

" Functions {{{
" Install Minimum Plugins
function! s:init_neobundle()
  if has("vim_starting")
    execute "set runtimepath+=" . s:neobundledir
  endif
  call neobundle#begin(s:bundledir)
  NeoBundleFetch "Shougo/neobundle.vim"  " Let NeoBundle manage NeoBundle
  NeoBundleLazy "Shougo/unite.vim", { "commands": ["Unite"] }
  NeoBundle "Shougo/vimproc", {
    \ "build": {
    \   "windows" : "make -f make_mingw32.mak",
    \   "cygwin"  : "make -f make_cygwin.mak",
    \   "mac"     : "make -f make_mac.mak",
    \   "unix"    : "make -f make_unix.mak",
    \ }}
endfunction

" Finish NeoBundle setting
function! s:finish_neobundle()
  call neobundle#end()
  filetype plugin indent on       " Required!
  NeoBundleCheck                  " Installation check.
endfunction

" bundled
function! s:bundled(bundle)
  if !isdirectory(s:bundledir)
    return 0
  endif
  if stridx(&runtimepath, s:neobundledir) == -1
    return 0
  endif

  if a:bundle ==# 'neobundle.vim'
    return 1
  else
    return neobundle#is_installed(a:bundle)
  endif
endfunction

" load_source
function! s:load_source(path)
  let path = expand(a:path)
  if filereadable(path)
    execute "source " . path
  endif
endfunction
" }}}

" Install Plugins
if !isdirectory(s:neobundledir) || v:version < 702
  let s:noplugin = 1

elseif isdirectory(s:neobundledir) && !isdirectory(s:bundledir)
  " If Neobundle is present and the plug-in is not installed,
  " I performed in preparation
  call s:init_neobundle()
  call s:finish_neobundle()

else
  " Shougo plugins {{{
  " -------------------------------------------------
  call s:init_neobundle()
  if has("lua") && ((v:version >= 703 && has("patch885")) || v:version >= 704)
    NeoBundleLazy "Shougo/neocomplete.vim", { "insert": 1 }
    " Combined with NeoComplCache
    let g:neocomplete#enable_at_startup = 1
  else
    NeoBundleLazy "Shougo/neocomplcache.vim", {"insert": 1 }
    " Cause is unknown, but NeoComplCacheEnable command is found, so change.
    let g:neocomplcache_enable_at_startup = 1
  endif
  NeoBundleLazy "Shougo/neosnippet.vim", {
    \  "depends" : ["honza/vim-snippets", "Shougo/neosnippet-snippets"],
    \  "insert"  : 1
    \ }

  NeoBundleLazy "Shougo/vimfiler", {
    \ "depends"  : ["Shougo/unite.vim"],
    \ "commands" : ["VimFiler", "VimFilerTab", "VimFilerExplorer"],
    \ }
  NeoBundleLazy "Shougo/vimshell", { "commands": ["VimShell"] }
  " }}}

  " thinca plugins {{{
  " -------------------------------------------------
  NeoBundleLazy "thinca/vim-quickrun", { "commands": ["Quickrun"] }
  NeoBundleLazy "thinca/vim-scouter", { "commands": ["Scouter"] }
  NeoBundleLazy "thinca/vim-ref", { "commands": ["vim-ref"] }
  NeoBundle "kashewnuts/vim-ft-rst_header"    " respect thinca/vim-ft-rst_header
  " }}}

  " Python plugins {{{
  " -------------------------------------------------
  NeoBundleLazy "davidhalter/jedi-vim", {
    \  "insert"    : 1,
    \  "filetypes" : ["python", "python3", "djangohtml", "jinja", "htmljinja"],
    \  "build"     : { "others" : "pip install jedi" }
    \ }
  NeoBundleLazy "lambdalisue/vim-django-support", {
    \  "filetypes": ["python", "python3", "djangohtml"] }
  NeoBundleLazy "jmcantrell/vim-virtualenv", {
    \  "filetypes" : ["python", "python3", "djangohtml", "jinja", "htmljinja"] }
  NeoBundleLazy "nvie/vim-flake8", {
    \  "filetypes" : ["python", "python3", "djangohtml", "jinja", "htmljinja"],
    \  "build"     : { "others" : "pip install flake8" }
    \ }
  NeoBundleLazy "tell-k/vim-autopep8", {
    \  "filetypes" : ["python", "python3"],
    \  "build"     : { "others" : "pip install autopep8" }
    \ }
  " }}}

  " Golang plugins {{{
  " -------------------------------------------------
  NeoBundleLazy "nsf/gocode", { "filetypes": ["go"] }
  NeoBundleLazy "Blackrush/vim-gocode", { "filetypes": ["go"] }
  " }}}

  " Java plugins {{{
  " -------------------------------------------------
  NeoBundleLazy "vim-scripts/javacomplete", { "insert" : 1, "filetypes" : ["java"] }
  " }}}

  " Scala plugins {{{
  " -------------------------------------------------
  NeoBundleLazy "derekwyatt/vim-scala", { "insert" : 1, "filetypes" : ["scala"] }
  " }}}

  " Haskell plugins {{{
  " -------------------------------------------------
  NeoBundleLazy "kana/vim-filetype-haskell"  , { "filetypes": "haskell" }
  NeoBundleLazy "eagletmt/ghcmod-vim"        , { "filetypes": "haskell" }
  NeoBundleLazy "eagletmt/neco-ghc"          , { "filetypes": "haskell" }
  NeoBundleLazy "ujihisa/ref-hoogle"         , { "filetypes": "haskell" }
  NeoBundleLazy "ujihisa/unite-haskellimport", { "filetypes": "haskell" }
  NeoBundleLazy "eagletmt/unite-haddock"     , { "filetypes": "haskell" }
  " }}}

  " Git plugins {{{
  " -------------------------------------------------
  NeoBundleLazy "mattn/gist-vim", {
    \ "depends" : ["mattn/webapi-vim"], "commands": ["Gist"] }
  NeoBundleLazy "gregsexton/gitv", {
    \ "depends" : ["tpope/vim-fugitive"], "commands": ["Gitv"] }
  " }}}

  " Editting support plugins {{{
  " -------------------------------------------------
  NeoBundleLazy "tpope/vim-surround", {
    \ "mappings" : [
    \   ["nx", "<Plug>Dsurround"], ["nx", "<Plug>Csurround"],
    \   ["nx", "<Plug>Ysurround"], ["nx", "<Plug>YSurround"],
    \   ["nx", "<Plug>Yssurround"], ["nx", "<Plug>YSsurround"],
    \   ["nx", "<Plug>YSsurround"], ["vx", "<Plug>VgSurround"],
    \   ["vx", "<Plug>VSurround"]
    \ ]}
  NeoBundleLazy "vim-scripts/Align", { "commands": ["Align"], }
  NeoBundleLazy "mrtazz/simplenote.vim", { "commands": ["Simplenote"] }
  NeoBundleLazy "mattn/emmet-vim", {
    \ "filetypes": ["html", "ruby", "php", "css", "haml", "xml"] }
  NeoBundleLazy "vim-scripts/SQLUtilities", {
    \ "depends" : ["Align"], "commands": ["SQLUFormatter"] }
  " NeoBundle "kana/vim-textobj-line"
  " }}}

  " Twitter plugins {{{
  " -------------------------------------------------
  NeoBundleLazy "basyura/TweetVim", {
    \ "depends": [
    \   "basyura/twibill.vim", "tyru/open-browser.vim", "mattn/webapi-vim",
    \   "h1mesuke/unite-outline", "basyura/bitly.vim", "mattn/favstar-vim"],
    \ "commands": ["TweetVimHomeTimeline", "TweetVimSay", "TweetVimListStatus",
    \              "TweetVimSearch", "TweetVimMentions"], }
  " }}}

  " Google plugin {{{
  " -------------------------------------------------
  " NeoBundleLazy "yuratomo/gmail.vim", { "commands": ["Gmail"] }
  NeoBundleLazy "kashewnuts/gmail.vim", { "commands": ["Gmail"] }
  NeoBundleLazy "itchyny/calendar.vim", { "commands": ["Calendar"] }
  " }}}


  " Plugins Settings
  " -------------------------------------------------

  " neocomplete.vim {{{
  if s:bundled('neocomplete.vim')
    let g:acp_enableAtStartup = 0            " NeoCompleteEnable
    let g:neocomplete#enable_smart_case = 1  " Use smartcase.

    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3

    " jedi omni completion
    au MyAutoCmd FileType python setl omnifunc=jedi#completions

    let g:jedi#auto_vim_configuration = 0
    if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_omni_input_patterns.python =
      \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
    let g:neocomplete#force_omni_input_patterns.go = '[^. \t]\.\w*'

    " Enable omni completion.
    au MyAutoCmd FileType css setl omnifunc=csscomplete#CompleteCSS
    au MyAutoCmd FileType html,markdown setl omnifunc=htmlcomplete#CompleteTags
    au MyAutoCmd FileType javascript setl omnifunc=javascriptcomplete#CompleteJS
    au MyAutoCmd FileType xml setl omnifunc=xmlcomplete#CompleteTags
  endif " }}}

  " neocomplcache.vim {{{
  if s:bundled("neocomplcache.vim")
    let g:acp_enableAtStartup = 0
    let g:neocomplcache_enable_smart_case = 1

    " jedi omni completion
    au MyAutoCmd FileType python setl omnifunc=jedi#completions
    let g:jedi#auto_vim_configuration = 0
    if !exists('g:neocomplcache_force_omni_patterns')
      let g:neocomplcache_force_omni_patterns = {}
    endif
    let g:neocomplcache_force_omni_patterns.python = '[^. \t]\.\w*'
  endif " }}}

  " neosnippet.vim {{{
  if s:bundled("neosnippet.vim")
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
  endif " }}}

  " vimfiler {{{
  if s:bundled("vimfiler")
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_safe_mode_by_default = 0
    " close vimfiler automatically when there are only vimfiler open
    nnoremap <Leader>e :VimFilerExplorer<CR>
    au MyAutoCmd BufEnter * if (
        \ winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
  endif " }}}

  " vim-quickrun {{{
  if s:bundled("vim-quickrun")
    nmap <Leader>r <Plug>(quickrun)
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
  endif " }}}

  " jedi-vim {{{
  if s:bundled("jedi-vim")
    let g:jedi#auto_initialization = 0
    let g:jedi#rename_command = "<leader>R"
    let g:jedi#popup_on_dot = 1
    let g:jedi#show_call_signatures = 0
    let g:jedi#popup_select_first = 0
    au MyAutoCmd FileType python let b:did_ftplugin = 1
    au MyAutoCmd FileType python setl completeopt-=preview " disable docstring
  endif " }}}

  " vim-flake8 {{{
  if s:bundled("vim-flake8")
    au MyAutoCmd BufWritePost *.py call Flake8()
  endif " }}}

  " Align {{{
  if s:bundled("Align")
    let g:Align_xstrlen = 3       " for japanese string
    let g:DrChipTopLvlMenu = ''   " remove 'DrChip' menu
  endif " }}}

  " simplenote.vim {{{
  if s:bundled("simplenote.vim")
    call s:load_source(expand('~/.simplenoterc'))
  endif " }}}

  " emmet-vim {{{
  if s:bundled("emmet-vim")
    let g:user_emmet_settings = {
    \  "php" : { "extends" : "html", "filters" : "c", },
    \  "xml" : { "extends" : "html", },
    \  "haml": { "extends" : "html", },
    \ }
  endif " }}}

  " gmail.vim {{{
  if s:bundled("gmail.vim")
    call s:load_source(expand('~/.anyname'))
  endif " }}}

  " TweetVim {{{
  if s:bundled("TweetVim")
    let g:tweetvim_display_time = 1
    let g:tweetvim_async_post = 1
  endif " }}}

  " calendar.vim {{{
  if s:bundled("calendar.vim")
    let g:calendar_frame = 'default'
    let g:calendar_google_calendar = 1
    let g:calendar_google_task = 1
  endif " }}}

  call s:finish_neobundle()
endif " }}}

" Local settings {{{
call s:load_source(expand('~/.vimrc.local'))
" }}}

" vim: tw=78 et st=2 sw=2 foldmethod=marker

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

" Encoding
set encoding=utf-8
scriptencoding utf-8

" release autogroup in MyAutoCmd
augroup MyAutoCmd
  au!
augroup END

" Environment
function! VimrcEnvironment()
  let env = {}
  let env.is_windows = has('win16') || has('win32') || has('win64')
  let env.is_darwin  = has('mac') || has('macunix') || has('gui_macvim')
  let env.is_ime     = has('multi byte_ime') || has('xim') || has('gui_macvim')
  return env
endfunction
let s:env = VimrcEnvironment()
" }}}

" Misc {{{
set guioptions+=M  " unload menu.vim
syntax on          " Enable syntax highlighting
set number         " Show line number (nonumber: Hide)
set smartindent    " Advanced automatic indentation when you made the new line
set showmatch matchtime=1       " The highlight matching brackets
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
set display=lastline                   " enable view long line
" disable annoying errorbells and visual bell completely
set noerrorbells novisualbell t_vb=
" Delete - characters that are displayed on the right side of the folding time
set fillchars=vert:\|
" Visualize character
if s:env.is_windows
  set list listchars=tab:>-,trail:-,extends:>,precedes:<
else
  set imdisable    " When you exit or enter, IME is turned off
  set list listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
endif
" }}}

" ColorScheme {{{
if !has('gui_running')
  " let s:colorscheme = (s:env.is_windows) ? 'desert' : 'adrian'
  " execute printf('colorscheme %s', s:colorscheme)
  colorscheme desert
endif
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

" Fix to become last line
noremap <expr> <C-b> max([winheight(0) - 2, 1]) . "\<C-u>" . (line('.') < 1         + winheight(0) ? 'H' : 'L')
noremap <expr> <C-f> max([winheight(0) - 2, 1]) . "\<C-d>" . (line('.') > line('$') - winheight(0) ? 'L' : 'H')
noremap <expr> <C-y> (line('w0') <= 1         ? 'k' : "\<C-y>")
noremap <expr> <C-e> (line('w$') >= line('$') ? 'j' : "\<C-e>")
" }}}

" ReOpen Encoding {{{
command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! Utf8 edit ++enc=utf-8
command! Jis Iso2022jp
command! Sjis Cp932
" }}}

" Grep {{{
au MyAutoCmd QuickFixCmdPost *grep* cwindow
" }}}

" FileType {{{
" ------------------------------------------------------------------------------
" ts   : tabstop
" sw   : shiftwidth
" sts  : softtabstop
" et   : expandtab
" noet : noexpandtab
" si   : smartindent
" cinw : cinwords
au MyAutoCmd FileType html       setl ts=4 sw=4 sts=4 et
au MyAutoCmd FileType htmldjango setl ts=2 sw=2 sts=2 et
au MyAutoCmd FileType javascript setl ts=4 sw=4 sts=4 et
au MyAutoCmd FileType ruby       setl ts=2 sw=2 sts=2 et
au MyAutoCmd FileType go         setl ts=4 sw=4 sts=4 noet
au MyAutoCmd FileType vim        setl ts=2 sw=2 sts=2 et
au MyAutoCmd FileType make       setl ts=4 sw=4 sts=4 noet
au MyAutoCmd FileType text       setl ts=4 sw=4 sts=4 et ft=rst
au MyAutoCmd FileType rst        setl ts=4 sw=4 sts=4 et
au MyAutoCmd FileType gitconfig  setl ts=4 sw=4 sts=4 noet
au MyAutoCmd FileType jsp        setl ts=4 sw=4 sts=4 noet
au MyAutoCmd FileType java       setl ts=4 sw=4 sts=4 noet
au MyAutoCmd FileType python     setl ts=4 sw=4 sts=4 et textwidth=80
au MyAutoCmd FileType sql        setl ts=4 sw=4 sts=4 et fenc=shift_jis ff=dos
au MyAutoCmd FileType scp        setl ts=4 sw=4 sts=4 noet fenc=shift_jis ff=dos dictionary=$HOME.'/.vim/dict/scp.dict'

" When the '#' character in the first line of the newly created,
" it isn't unindent
au MyAutoCmd FileType python inoremap # X#
au MyAutoCmd BufNewFile *.py 0r ~/.vim/template/python.txt

" Golang settings {{{
if $GOROOT !=# ''
  set rtp+=$GOROOT/misc/vim
  set completeopt=menu,preview
  if $GOPATH !=# ''
    " gocode
    exe 'set rtp+='.globpath($GOPATH, 'src/github.com/nsf/gocode/vim')
    " golint
    exe 'set rtp+='.globpath($GOPATH, 'src/github.com/golang/lint/misc/vim')
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

" PHP settings {{{
let g:php_baselib       = 1
let g:php_htmlInStrings = 1
let g:php_noShortTags   = 1
let g:php_sql_query     = 1
" }}}
" }}}

" After Vim7.4 {{{
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

" nofixeol {{{
if exists('&nofixeol')
  set nofixeol
endif "}}}
" }}}

" Function {{{
" ------------------------------------------------------------------------------
" Cheerless cursor position is moved
function! s:remove_dust()
  let s:cursor = getpos('.')
  %s/\s\+$//e  " Remove trailing whitespace on save
  %s/\t/  /e   " Converted to 2 whitespace tab when you save
  call setpos('.', s:cursor)
  unlet s:cursor
endfunction
au MyAutoCmd BufWritePre *.py call <SID>remove_dust()
au MyAutoCmd BufWritePre *.txt call <SID>remove_dust()
au MyAutoCmd BufWritePre *.rst call <SID>remove_dust()

" Display full-width space
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

" load_source
function! s:load_source(path)
  let path = expand(a:path)
  if filereadable(path)
    execute 'source ' . path
  endif
endfunction

" bundled
function! s:bundled(bundle)
  if !isdirectory(expand('~/.vim/dein'))
    return 0
  endif
  if stridx(&runtimepath, '~/.vim/dein/repos/github.com/Shougo/dein.vim') == -1
    return 0
  endif
endfunction " }}}

" dein.vim {{{
" " ------------------------------------------------------------------------------
let s:noplugin = 0
let s:dein = expand('~/.vim/dein')

if !isdirectory(s:dein) || v:version < 702
  let s:noplugin = 1

elseif isdirectory(s:dein) && v:version >= 704
  set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
  call dein#begin(s:dein)

  " Shougo plugins {{{
  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/unite.vim', {'on_cmd': 'Unite'})
  call dein#add('Shougo/vimproc.vim', {
      \ 'build': {
      \     'windows': 'tools\\update-dll-mingw',
      \     'cygwin': 'make -f make_cygwin.mak',
      \     'mac': 'make -f make_mac.mak',
      \     'linux': 'make',
      \     'unix': 'gmake',
      \    },
      \ })
  if has('lua') && (v:version >= 704)
    call dein#add('Shougo/neocomplete.vim', {'on_i': 1})
    " Combined with NeoComplCache
    let g:neocomplete#enable_at_startup = 1
  else
    call dein#add('Shougo/neocomplcache.vim', {'on_i': 1})
    " Cause is unknown, but NeoComplCacheEnable command is found, so change.
    let g:neocomplcache_enable_at_startup = 1
  endif
  " }}}

  " thinca plugins {{{
  call dein#add('thinca/vim-quickrun', {'on_cmd': 'Quickrun'})
  call dein#add('thinca/vim-scouter', {'on_cmd': 'Scouter'})
  " }}}

  " Web plugins {{{
  call dein#add('hail2u/vim-css3-syntax', {
    \ 'on_i': 1 ,
    \ 'on_ft': ['html', 'css', 'javascript', 'jinja', 'htmljinja']})
  call dein#add('othree/html5.vim', {
    \ 'on_i': 1,
    \ 'on_ft': ['html', 'css', 'javascript', 'jinja', 'htmljinja']})
  call dein#add('pangloss/vim-javascript', {
    \ 'on_i': 1,
    \ 'on_ft': ['html', 'css', 'javascript', 'jinja', 'htmljinja']})
  call dein#add('mattn/emmet-vim', {'on_ft': ['html', 'ruby', 'php', 'css', 'haml', 'xml']})
  " }}}

  " Python plugins {{{
  call dein#add('davidhalter/jedi-vim', {
    \ 'on_i': 1,
    \ 'on_ft': ['python', 'python3', 'djangohtml', 'jinja', 'htmljinja'],
    \ 'build': {'others' : 'pip install jedi'}})
  call dein#add('lambdalisue/vim-django-support', {
    \ 'on_ft': ['python', 'python3', 'djangohtml']})
  call dein#add('jmcantrell/vim-virtualenv', {
    \ 'on_ft': ['python', 'python3', 'djangohtml', 'jinja', 'htmljinja']})
  call dein#add('nvie/vim-flake8', {
    \ 'on_ft': ['python', 'python3', 'djangohtml', 'jinja', 'htmljinja'],
    \ 'build': {'others' : 'pip install flake8'}})
  call dein#add('tell-k/vim-autopep8', {
    \ 'on_ft': ['python', 'python3'],
    \ 'build': {'others' : 'pip install autopep8'}})
  " }}}

  " Syntastic {{{
  call dein#add('osyo-manga/shabadou.vim')
  call dein#add('jceb/vim-hier')
  call dein#add('dannyob/quickfixstatus')
  call dein#add('osyo-manga/vim-watchdogs', {'on_cmd': 'WatchdogsRun'})
  " }}}

  " Golang plugins {{{
  call dein#add('nsf/gocode', {'on_ft': 'go'})
  call dein#add('Blackrush/vim-gocode', {'on_ft': 'go'})
  " }}}

  " Java plugins {{{
  call dein#add('vim-scripts/javacomplete', {'on_i': 1}, {'on_ft': 'java'})
  " }}}

  " Scala plugins {{{
  call dein#add('derekwyatt/vim-scala', {'on_i': 1}, {'on_ft': 'scala'})
  " }}}

  " Haskell plugins {{{
  call dein#add('kana/vim-filetype-haskell'  , {'on_ft': 'haskell'})
  call dein#add('eagletmt/ghcmod-vim'        , {'on_ft': 'haskell'})
  call dein#add('eagletmt/neco-ghc'          , {'on_ft': 'haskell'})
  call dein#add('ujihisa/ref-hoogle'         , {'on_ft': 'haskell'})
  call dein#add('ujihisa/unite-haskellimport', {'on_ft': 'haskell'})
  call dein#add('eagletmt/unite-haddock'     , {'on_ft': 'haskell'})
  " }}}

  " Git plugins {{{
  call dein#add('mattn/gist-vim', {'on_cmd': 'Gist'})
  call dein#add('tpope/vim-fugitive')
  call dein#add('gregsexton/gitv', {'on_cmd': 'Gitv'})
  " }}}

  " Edit plugins {{{
  call dein#add('kashewnuts/vim-ft-rst_header')
  call dein#add('tpope/vim-surround')
  call dein#add('vim-scripts/Align')
  call dein#add('mrtazz/simplenote.vim', {'on_cmd': 'Simplenote'})
  call dein#add('vim-scripts/SQLUtilities', {'on_cmd': 'SQLUFormatter'})
  call dein#add('itchyny/lightline.vim')
  " }}}

  " Twitter {{{
  call dein#add('basyura/twibill.vim')
  call dein#add('tyru/open-browser.vim')
  call dein#add('mattn/webapi-vim')
  call dein#add('h1mesuke/unite-outline')
  call dein#add('basyura/bitly.vim')
  call dein#add('mattn/favstar-vim')
  call dein#add('basyura/TweetVim',
    \ {'on_cmd': ['TweetVimHomeTimeline', 'TweetVimSay', 'TweetVimListStatus',
    \            'TweetVimSearch', 'TweetVimMentions']})
  " }}}
  call dein#end()

  let g:dein#types#git#clone_depth = 1
  if dein#check_install()
    call dein#install()
  endif
  filetype plugin indent on       " Required!
endif
" }}}

" Plugin settings {{{
" ------------------------------------------------------------------------------
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

  " let g:neocomplete#sources#dictionary#dictionaries = { 'default':    '' }
  " let g:neocomplete#sources#dictionary#dictionaries = {
  "   \ 'default':    '',
  "   \ 'vimshell':   $HOME.'/.vimshell_hist',
  "   \ 'scala':      $HOME.'/.vim/bundle/vim-scala/dict/scala.dict',
  "   \ 'c':          $HOME.'/.vim/dict/c.dict',
  "   \ 'cpp':        $HOME.'/.vim/dict/cpp.dict',
  "   \ 'java':       $HOME.'/.vim/dict/java.dict',
  "   \ 'lua':        $HOME.'/.vim/dict/lua.dict',
  "   \ 'ocaml':      $HOME.'/.vim/dict/ocaml.dict',
  "   \ 'perl':       $HOME.'/.vim/dict/perl.dict',
  "   \ 'php':        $HOME.'/.vim/dict/php.dict',
  "   \ 'scheme':     $HOME.'/.vim/dict/scheme.dict',
  "   \ 'vim':        $HOME.'/.vim/dict/vim.dict'
  "   \ }

  " Enable omni completion.
  au MyAutoCmd FileType css setl omnifunc=csscomplete#CompleteCSS
  au MyAutoCmd FileType html,markdown setl omnifunc=htmlcomplete#CompleteTags
  au MyAutoCmd FileType javascript setl omnifunc=javascriptcomplete#CompleteJS
  au MyAutoCmd FileType xml setl omnifunc=xmlcomplete#CompleteTags
endif " }}}

" neocomplcache.vim {{{
if s:bundled('neocomplcache.vim')
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
if s:bundled('neosnippet.vim')
  " Plugin key-mappings.
  imap <C-k>   <Plug>(neosnippet_expand_or_jump)
  smap <C-k>   <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>   <Plug>(neosnippet_expand_target)

  " SuperTab like snippets behavior.
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ '\<Plug>(neosnippet_expand_or_jump)'
        \: pumvisible() ? '\<C-n>' : '\<TAB>'
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ '\<Plug>(neosnippet_expand_or_jump)'
        \: '\<TAB>'

  " For snippet_complete marker.
  if has('conceal')
    set conceallevel=2 concealcursor=i
  endif

  " Enable snipMate compatibility feature.
  let g:neosnippet#enable_snipmate_compatibility = 1

  " Tell Neosnippet about the other snippets
  let g:neosnippet#snippets_directory=s:bundledir.'/vim-snippets/snippets'
endif " }}}

" vimfiler {{{
if s:bundled('vimfiler')
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_safe_mode_by_default = 0
  " close vimfiler automatically when there are only vimfiler open
  nnoremap <Leader>e :VimFilerExplorer<CR>
  au MyAutoCmd BufEnter * if (
      \ winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
endif " }}}

" vim-quickrun {{{
if s:bundled('vim-quickrun')
  nmap <Leader>r <Plug>(quickrun)
  " Open at the height of 10-digit buffer window by horizontal split at the bottom
  " Enable asynchronous processing
  " Disable the Sheban prevent garbled in a Windows environment
  let g:quickrun_config = {
  \  '_' : {
  \      'outputter/buffer/split' : ':botright 10sp',
  \      'runner' : 'vimproc',
  \      'hook/shebang/enable' : 0,
  \  }
  \ }
endif " }}}

" jedi-vim {{{
if s:bundled('jedi-vim')
  let g:jedi#auto_initialization = 0
  let g:jedi#rename_command = '<leader>R'
  let g:jedi#popup_on_dot = 1
  let g:jedi#show_call_signatures = 0
  let g:jedi#popup_select_first = 0
  au MyAutoCmd FileType python let b:did_ftplugin = 1
  au MyAutoCmd FileType python setl completeopt-=preview " disable docstring
endif " }}}

" vim-flake8 {{{
if s:bundled('vim-flake8')
  au MyAutoCmd BufWritePost *.py call Flake8()
endif " }}}

" Align {{{
if s:bundled('Align')
  let g:Align_xstrlen = 3       " for japanese string
  let g:DrChipTopLvlMenu = ''   " remove 'DrChip' menu
endif " }}}

" simplenote.vim {{{
if s:bundled('simplenote.vim')
  if s:env.is_windows
    let g:SimplenoteListHeight=50
  else
    let g:SimplenoteListHeight=35
  endif
  let g:SimplenoteFiletype ='rst'
  call s:load_source(expand('~/.simplenoterc'))
endif " }}}

" emmet-vim {{{
if s:bundled('emmet-vim')
  let g:user_emmet_settings = {
  \  'php' : { 'extends' : 'html', 'filters' : 'c', },
  \  'xml' : { 'extends' : 'html', },
  \  'haml': { 'extends' : 'html', },
  \ }
endif " }}}

" TweetVim {{{
if s:bundled('TweetVim')
  let g:tweetvim_display_time = 1
  let g:tweetvim_async_post = 1
endif " }}}

" lightline.vim {{{
if s:bundled('lightline.vim')
  let g:lightline = {
    \ 'colorscheme': 'default',
    \ }
  set laststatus=2
  if !has('gui_running')
    set t_Co=256
  endif
  au MyAutoCmd bufwritepost $MYVIMRC nested source $MYVIMRC
endif " }}}
" }}}

" Local settings {{{
call s:load_source(expand('~/.vim/plugins/recognize_charcode.vim'))
call s:load_source(expand('~/.vimrc.local'))
" }}}

" vim: tw=78 et st=2 sw=2 foldmethod=marker

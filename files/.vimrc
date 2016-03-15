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
  let l:env = {}
  let l:env.is_windows = has('win16') || has('win32') || has('win64')
  let l:env.is_darwin  = has('mac') || has('macunix') || has('gui_macvim')
  let l:env.is_ime     = has('multi byte_ime') || has('xim') || has('gui_macvim')
  return l:env
endfunction
let s:env = VimrcEnvironment()
" }}}

" Misc {{{
set guioptions+=M  " Disable menu.vim
set guioptions-=T  " Disable Toolbar
set guioptions-=m  " Disable Menu bar
set number         " Show line number (nonumber: Hide)
set autoindent smartindent  " Advanced automatic indentation when you made the new line
set copyindent     " copy the structure of the existing lines indent when
                   " autoindenting a new line
set showmatch matchtime=1   " The highlight matching brackets
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
set ignorecase     " ignore case when searching
set smartcase      " no ignorecase if Uppercase char present
set laststatus=2   " Always display status bar
" For when no lightline.vim
set statusline=%F%m%r%h%w\%=[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fileencoding}]\[LOW=%l/%L]
set cmdheight=2    " cmdline height
set matchpairs& matchpairs+=<:> " To support brackets add a pair of '<' and '>'
set backspace=indent,eol,start  " Can erase everything in the back space
set wildmenu wildmode=list:full " Command-line completion
" Use the OS clipboard
if has('clipboard')
  set clipboard+=unnamed,autoselect
endif
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
au MyAutoCmd QuickFixCmdPost *grep* cwindow " Auto open quickfix-window
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
au MyAutoCmd FileType scp        setl ts=4 sw=4 sts=4 noet fenc=shift_jis ff=dos
au MyAutoCmd FileType scp        setl dictionary='~/.vim/dict/scp.dict' suffixesadd+=.scp

" When the '#' character in the first line of the newly created,
" it isn't unindent
au MyAutoCmd FileType python inoremap # X#
au MyAutoCmd BufNewFile *.py 0r ~/.vim/template/python.txt

" Golang settings {{{
if $GOROOT !=# ''
  set runtimepath+=$GOROOT/misc/vim
  set completeopt=menu,preview
  if $GOPATH !=# ''
    " gocode
    exe 'set runtimepath+='.globpath($GOPATH, 'src/github.com/nsf/gocode/vim')
    " golint
    exe 'set runtimepath+='.globpath($GOPATH, 'src/github.com/golang/lint/misc/vim')
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
  let l:path = expand(a:path)
  if filereadable(l:path)
    execute 'source ' . l:path
  endif
endfunction
" }}}
" 
" " dein.vim {{{
" " ------------------------------------------------------------------------------
" " Cache
" let $CACHE = expand('~/.cache')
" if !isdirectory(expand($CACHE))
"   call mkdir(expand($CACHE), 'p')
" endif
" 
" " Load dein.vim
" if v:version >= 704 && isdirectory(expand('~/.vim'))
"   " Begin dein.vim
"   let s:dein_dir = finddir('dein.vim', '.;')
"   if s:dein_dir !=# '' || &runtimepath !~# '/dein.vim'
"     if s:dein_dir ==# '' && &runtimepath !~# '/dein.vim'
"       let s:dein_dir = expand('$CACHE/dein') . '/repos/github.com/Shougo/dein.vim'
" 
"       if !isdirectory(s:dein_dir)
"         execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
"       endif
"     endif
"     set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
"   endif
"   let s:path = expand('~/.cache/dein')
"   let s:toml_path = '~/.vim/rc/dein.toml'
"   let s:toml_lazy_path = '~/.vim/rc/dein_lazy.toml'
" 
"   " Read TOML & cache
"   if dein#load_state(s:path)
"     call dein#begin(s:path)
"     call dein#load_toml(s:toml_path, {'lazy': 0})
"     call dein#load_toml(s:toml_lazy_path, {'lazy' : 1})
"     call dein#end()
"     call dein#save_state()
"     call s:load_source(expand('~/.vim/rc/plugins.vim'))
"   endif
" 
"   let g:dein#types#git#clone_depth = 1
"   " Install plugins to asynchronous
"   if dein#check_install(['vimproc.vim'])
"     call dein#install(['vimproc.vim'])
"   endif
"   if dein#check_install()
"     call dein#install()
"   endif
" endif
" " }}}
" 
" Others {{{
" IME setting {{{
if s:env.is_ime
  " Insert, Search mode: ime setting
  set iminsert=0
  set imsearch=-1
  " Normal mode: IME off
  inoremap <silent> <Esc><Esc>:set iminsert=0<CR>
endif " }}}

" STOP default plugins {{{
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_rrhelper          = 1
let g:loaded_2html_plugin      = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_LogiPat           = 1
let g:loaded_logipat           = 1
let g:plugin_autodate_disable  = 1
let g:plugin_cmdex_disable     = 1
let g:plugin_dicwin_disable    = 1
let g:plugin_format_disable    = 1
let g:plugin_hz_ja_disable     = 1
let g:plugin_scrnmode_disable  = 1
let g:plugin_verifyenc_disable = 1
" }}}
" Enable syntax highlighting
syntax on
" ColorScheme
if !(has('gui_running') && filereadable(expand('~/.gvimrc')))
  colorscheme desert
endif
" }}}

" Local settings {{{
call s:load_source(expand('~/.vim/plugins/recognize_charcode.vim'))
call s:load_source(expand('~/.vimrc.local'))
set secure
" }}}

" vim: tw=78 et sw=2 foldmethod=marker

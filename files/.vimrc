" ==========================================================================
" Vim Configuration
"
" Author:   Kashun YOSHIDA
" Platform: Windows, Linux, MacOSX
" NOTE:     To use this, copy to your home directory.
" ==========================================================================

" Basic Settings {{{
if !1 | finish | endif  " skip if the live Vim is vim-tiny or vim-small
if &compatible | set nocompatible | endif  " For dein.vim

" Encoding
set encoding=utf-8
scriptencoding utf-8

" Environment
function! VimrcEnvironment()
  let s:env = {}
  let s:env.IsWindows = has('win16') || has('win32') || has('win64')
  let s:env.IsDarwin  = has('mac') || has('macunix') || has('gui_macvim')
  let s:env.IsIme     = has('multi byte_ime') || has('xim') || has('gui_macvim')
  return s:env
endfunction
let s:env = VimrcEnvironment()

" autocmd
augroup MyAutoCmd
  au!
augroup END
" }}}

" GUI {{{
set guifont=MeiryoKe_Gothic:h10,MS_Gothic:h10,Osaka-Mono:h14
set guioptions+=M       " Disable menu.vim
set guioptions-=T       " Disable Toolbar
set guioptions-=m       " Disable Menu bar
" }}}

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

" Misc {{{
set ambiwidth=double            " Use twice the width of ASCII characters
set autoindent                  " For smartindent
set backspace=indent,eol,start  " Can erase everything in the back space
if has('clipboard') | set clipboard+=unnamed | endif  " Use the OS clipboard
set cmdheight=2                 " cmdline height
set copyindent                  " copy the indent structure of existing lines
set display=lastline            " enable view long line
set expandtab                   " noexpand tabs to spaces (expandtab: expand)
" Delete - characters that are displayed on the right side of the folding time
set fillchars=vert:\|
set fileformats=unix,dos,mac    " This gives the end-of-line (<EOL>) formats
set history=1000                " history
set hlsearch                    " highlight searches
set ignorecase                  " ignore case when searching
set iminsert=0 imsearch=-1      " Insert, Search mode: ime setting
set incsearch                   " do incremental searching
set laststatus=2                " Always display status bar
set lazyredraw                  " Only redraw when necessary.
set list listchars=tab:>-,trail:-,extends:>,precedes:<  " Visualize character
set matchpairs& matchpairs+=<:> " To support brackets add a pair of '<' and '>'
set noerrorbells novisualbell t_vb=    " disable annoying bells
set noswapfile nobackup nowritebackup  " doesn't generate a backup file
set number                      " Show line number (nonumber: Hide)
set ruler                       " show the current row and column
set shiftwidth=4                " Shift move width
set showmatch matchtime=1       " The highlight matching brackets
set smartcase      " no ignorecase if Uppercase char present
set smartindent    " Advanced automatic indentation when you made the new line
set smarttab       " Indent by the number of 'shiftwidth'.
set softtabstop=4  " Number of spaces in the file space is the corresponding
" For when no lightline.vim
set statusline=%F%m%r%h%w\%=\[%{&ff}]\[%{strlen(&fenc)?&fenc:&enc}][%{strlen(&ft)?&ft:'no\ ft'}]\[%l-%c]
set tabstop=4                   " Width on the screen of the tab
set ttyfast                     " Faster redrawing.
set wildmenu wildmode=list:full " Command-line completion
" }}}

" KeyMaping {{{
" Normal mode: IME off
inoremap <silent> <Esc><Esc>:set iminsert=0<CR>

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
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

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

" After Vim7.4 {{{
if exists('&undofile') | set noundofile | endif  " Don't make *.un~ files
if exists('&nofixeol') | set nofixeol | endif
if v:version >= 704 && has('patch338')  " breakindent {{{
  " https://github.com/vim-jp/issues/issues/114
  " http://ftp.vim.org/vim/patches/7.4/7.4.338
  set breakindent
endif "}}}
" }}}

function! s:load_source(path) " {{{
  let l:path = expand(a:path)
  if filereadable(l:path)
    execute 'source ' . l:path
  endif
endfunction
call s:load_source(expand('~/.vim/rc/filetype.rc.vim'))
call s:load_source(expand('~/.vim/rc/dein.rc.vim'))
" }}}

" Default Window Size {{{
if has('gui_running') && !filereadable(expand('~/.vimwinpos'))
  set lines=45 columns=100
  winpos 0 0
endif " }}}

" Others {{{
call s:load_source(expand('~/.vimrc.local'))
filetype plugin indent on       " Load plugins according to detected filetype.
syntax on                       " Enable syntax highlight
colorscheme desert
set secure
" }}}

" vim: tw=78 et sw=2 foldmethod=marker

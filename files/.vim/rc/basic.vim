" Basic {{{
if !1 | finish | endif  " skip if the live Vim is vim-tiny or vim-small

if &compatible
  set nocompatible
endif " }}}

" Encoding {{{
set encoding=utf-8
set fileformats=unix,dos,mac
scriptencoding utf-8 " }}}

" GUI {{{
set guifont=MeiryoKe_Gothic:h10,MS_Gothic:h10,Osaka-Mono:h14
set guioptions+=M  " Disable menu.vim
set guioptions-=T  " Disable Toolbar
set guioptions-=m  " Disable Menu bar
" }}}

" Misc {{{
set number         " Show line number (nonumber: Hide)
set history=1000   " history
set autoindent     " Copy indent from current line when starting a new line
set smartindent    " Do smart autoindenting when starting a new line.
set copyindent     " copy the structure of the existing lines indent when
                   " autoindenting a new line
set ambiwidth=double            " Use twice the width of ASCII characters
set showmatch matchtime=1       " The highlight matching brackets
set matchpairs& matchpairs+=<:> " To support brackets add a pair of '<' and '>'
set backspace=indent,eol,start  " Can erase everything in the back space
set iminsert=0 imsearch=-1      " Insert, Search mode: ime setting
set clipboard+=unnamed,autoselect
set list listchars=tab:>-,trail:-,extends:>,precedes:<  " Visualize character
" }}}

" Tab {{{
set tabstop=4      " Width on the screen of the tab
set softtabstop=4  " Number of spaces in the file space is the corresponding
set expandtab      " expand tabs to spaces
set shiftwidth=4   " Shift move width
set smarttab       " Indent by the number of 'shiftwidth'.
set textwidth=0    " Disable new line to enter automatically
" }}}

" Search {{{
set hlsearch       " highlight searches
set incsearch      " do incremental searching
set ignorecase     " ignore case when searching
set smartcase      " no ignorecase if Uppercase char present
" }}}

" Cmdline {{{
set cmdheight=2                 " Cmdline height
set wildmenu wildmode=list:full " Command-line completion
set display=lastline            " enable view long line
set laststatus=2                " Always display status bar
set statusline=%F%m%r%h%w\%=\[%{&ff}]\[%{strlen(&fenc)?&fenc:&enc}][%{strlen(&ft)?&ft:'no\ ft'}]\[%l-%c]
" }}}

" Disable {{{
set noerrorbells novisualbell t_vb=              " Disable annoying bells
set noswapfile nobackup nowritebackup noundofile " Doesn't generate backup files
" }}}

function! s:load_source(path) " {{{
  let l:path = expand(a:path)
  if filereadable(l:path)
    execute 'source ' . l:path
  endif
endfunction
call s:load_source(expand('~/.vim/rc/filetype.rc.vim'))
call s:load_source(expand('~/.vim/rc/dein.rc.vim'))
call s:load_source(expand('~/.vim/rc/plugins.vim'))
call s:load_source(expand('~/.vimrc.local')) " }}}

filetype plugin indent on
syntax on
colorscheme desert
set secure

" vim: tw=78 et sw=2 foldmethod=marker

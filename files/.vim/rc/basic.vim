if !1 | finish | endif  " skip if the live Vim is vim-tiny or vim-small

if &compatible
  set nocompatible
endif
set encoding=utf-8
set fileformats=unix,dos,mac
scriptencoding utf-8

set guioptions+=M  " Disable menu.vim
set guioptions-=T  " Disable Toolbar
set guioptions-=m  " Disable Menu bar

set number         " Show line number (nonumber: Hide)
set history=1000   " history
set autoindent     " Copy indent from current line when starting a new line
set smartindent    " Do smart autoindenting when starting a new line.
set copyindent     " copy the structure of the existing lines indent when
                   " autoindenting a new line
set tabstop=4      " Width on the screen of the tab
set softtabstop=4  " Number of spaces in the file space is the corresponding
set expandtab      " expand tabs to spaces
set shiftwidth=4   " Shift move width
set smarttab       " Indent by the number of 'shiftwidth'.
set textwidth=0    " Disable new line to enter automatically

set hlsearch       " highlight searches
set incsearch      " do incremental searching
set ignorecase     " ignore case when searching
set smartcase      " no ignorecase if Uppercase char present

set cmdheight=2                 " Cmdline height
set wildmenu wildmode=list:full " Command-line completion
set display=lastline            " enable view long line
set laststatus=2                " Always display status bar
set statusline=%F%m%r%h%w\%=\[%{&ff}]\[%{strlen(&fenc)?&fenc:&enc}][%{strlen(&ft)?&ft:'no\ ft'}]\[%l-%c]

set ambiwidth=double            " Use twice the width of ASCII characters
set showmatch matchtime=1       " The highlight matching brackets
set matchpairs& matchpairs+=<:> " To support brackets add a pair of '<' and '>'
set backspace=indent,eol,start  " Can erase everything in the back space
set iminsert=0 imsearch=-1      " Insert, Search mode: ime setting
set clipboard+=unnamed,autoselect
set list listchars=tab:>-,trail:-,extends:>,precedes:<  " Visualize character

set noerrorbells novisualbell t_vb=              " Disable annoying bells
set noswapfile nobackup nowritebackup noundofile " Doesn't generate backup files
set nofixeol
set breakindent
set guifont=MeiryoKe_Gothic:h10,MS_Gothic:h10,Osaka-Mono:h14

function! s:load_source(path) " {{{
  let l:path = expand(a:path)
  if filereadable(l:path)
    execute 'source ' . l:path
  endif
endfunction " }}}
call s:load_source(expand('~/.vim/rc/filetype.rc.vim'))
call s:load_source(expand('~/.vim/rc/dein.rc.vim'))
call s:load_source(expand('~/.vimrc.local'))

syntax on  " Enable syntax highlight
colorscheme desert
set secure

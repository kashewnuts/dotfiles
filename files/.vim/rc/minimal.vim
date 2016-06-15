" Basic
if !1 | finish | endif       " skip if the live Vim is vim-tiny or vim-small

" Encoding
set encoding=utf-8           " Sets the character encoding used inside Vim
set fileformats=unix,dos,mac " This gives the <EOL>
scriptencoding utf-8         " Specify the character encoding used in the script

" Disable
set guioptions=Mc            " Disable menu.vim & Use console dialog
set noerrorbells novisualbell t_vb=              " Disable annoying bells
set noswapfile nobackup nowritebackup noundofile " Doesn't generate backup files

" Appearance
set ambiwidth=double            " Use twice the width of ASCII characters
set display=lastline            " Enable view long line
set history=1000                " History
set list listchars=tab:>-,trail:-,extends:>,precedes:<  " Visualize character
set number                      " Show line number (nonumber: Hide)
set showmatch matchtime=1       " The highlight matching brackets

" Edit
set backspace=indent,eol,start  " Can erase everything in the back space
if has('clipboard') | set clipboard=unnamed | endif " Use the OS clipboard
set iminsert=0 imsearch=-1      " Insert, Search mode: ime setting
set matchpairs& matchpairs+=<:> " To support brackets add a pair of '<' and '>'

" Indent
set autoindent     " For smartindent
set smartindent    " Advanced automatic indentation when you made the new line
set copyindent     " copy the indent structure of existing lines

" Tab
set tabstop=4      " Width on the screen of the tab
set softtabstop=4  " Number of spaces in the file space is the corresponding
set expandtab      " noexpand tabs to spaces (expandtab: expand)
set shiftwidth=4   " Shift move width
set smarttab       " Indent by the number of 'shiftwidth'.

" Search
set hlsearch       " highlight searches
set incsearch      " do incremental searching
set ignorecase     " ignore case when searching
set smartcase      " no ignorecase if Uppercase char present

" Commandline & Statusline
set cmdheight=2                 " Cmdline height
set wildmenu wildmode=list:full " Command-line completion
set laststatus=2                " Always display status bar
set statusline=%F%m%r%h%w\%=\[%{&ff}]\[%{strlen(&fenc)?&fenc:&enc}][%{strlen(&ft)?&ft:'no\ ft'}]\[%l-%c/%L]

" Essential
filetype plugin indent on       " Load plugins according to detected filetype.
syntax on                       " Enable syntax highlight
colorscheme desert

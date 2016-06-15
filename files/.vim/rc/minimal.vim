" Basic
if !1 | finish | endif          " Skip if the live Vim is vim-tiny or vim-small
if &compatible | set nocompatible | endif " Make Vim behave in a more useful way

" Encoding
set encoding=utf-8              " Sets the character encoding used inside Vim
scriptencoding utf-8            " Specify encoding used in the script
set fileformats=unix,dos,mac    " This gives the <EOL>

" Disable
set guioptions=Mc               " Disable menu.vim & Use console dialog
set noerrorbells novisualbell t_vb=              " Disable annoying bells
set noswapfile nobackup nowritebackup noundofile " Doesn't generate backup files

" Appearance
set ambiwidth=double            " Use twice the width of ASCII characters
set display=lastline            " Enable view long line
set history=1000                " History
set list listchars=tab:>-,trail:-  " Visualize character
set number                      " Show line number (nonumber: Hide)
set scrolloff=999               " Keep above and below the cursor
set showmatch matchtime=1       " The highlight matching brackets

" Edit
set backspace=indent,eol,start  " Can erase everything in the back space
if has('clipboard') | set clipboard=unnamed | endif " Use the OS clipboard
set iminsert=0 imsearch=-1      " Insert, Search mode: ime setting
set matchpairs& matchpairs+=<:> " To support brackets add a pair of '<' and '>'

" Indent
set autoindent     " Copy indent from current line when starting a new line
set smartindent    " Do smart autoindenting when starting a new line
set copyindent     " Copy the structure of the existing lines indent

" Tab
set tabstop=4      " Width on the screen of the tab
set softtabstop=4  " Number of spaces in the file space is the corresponding
set expandtab      " noexpand tabs to spaces (expandtab: expand)
set shiftwidth=4   " Shift move width
set smarttab       " Indent by the number of 'shiftwidth'.

" Search
set hlsearch       " Highlight searches
set incsearch      " Do incremental searching
set ignorecase     " Ignore case when searching
set smartcase      " No ignorecase if Uppercase char present

" Command-line
set cmdheight=2                 " Command-line height
set wildmenu wildmode=list:full " Command-line completion

" Statusline
set laststatus=2                " Always display status bar
set statusline&                 " Init
set statusline+=%F              " FileName(Relative Pathname)
set statusline+=%m              " Fix flag([+] or [-])
set statusline+=%r              " Read only flg([RO])
set statusline+=%h              " Help buffer
set statusline+=%w              " Preview window flag
set statusline+=%=              " Separated left & right item
set statusline+=[%{&ff}]                        " View FileFormat
set statusline+=[%{strlen(&fenc)?&fenc:&enc}]   " FileEncording
set statusline+=[%{strlen(&ft)?&ft:'no\ ft'}]   " FileType
set statusline+=[%l-%c/%L]                      " Cursor-Now Column/Total Number

" Essential
filetype plugin indent on       " Load plugins according to detected filetype.
syntax on                       " Enable syntax highlight
try | colorscheme molokai | catch colorscheme desert | endtry

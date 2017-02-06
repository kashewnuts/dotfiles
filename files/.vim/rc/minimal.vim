" --- Init ---
set encoding=utf-8              " Sets the character encoding used inside Vim
scriptencoding utf-8            " Specify encoding used in the script
autocmd!
" --- Disable ---
set guioptions=M noerrorbells novisualbell t_vb=    " Turn off menu & bell
set noswapfile nobackup nowritebackup noundofile    " Doesn't make backup file
" --- Appearance ---
set ambiwidth=double                " Use twice the width of ASCII characters
set backspace=indent,eol,start      " Can erase everything in the back space
set cmdheight=2 wildmenu wildmode=list:full         " Command-line
if has('clipboard') | set clipboard=unnamed | endif " Use the OS clipboard
set display=lastline                " Enable view long line
set fileformats=unix,dos            " This gives the end-of-line formats
set helpheight=999                  " Open help to fill the screen
set history=1000                    " History
set list listchars=tab:>-,trail:-   " Visualize character
set matchpairs& matchpairs+=<:>     " To support brackets a pair of '<' & '>'
set number                          " Show line number (nonumber: Hide)
set showmatch matchtime=1           " The highlight matching brackets
set tags=./tags;                    " Refer to projects root tags file
set ttimeout timeoutlen=300 ttimeoutlen=50          " Speedup for ESC
autocmd InsertLeave * set iminsert=0 imsearch=-1    " IME off
" --- Grep ---
if executable('pt') | let &grepprg='pt --nocolor --nogroup --hidden -S' | endif
autocmd QuickFixCmdPost *grep* cwindow  " Auto open quickfix-window
" --- Indent ---
set autoindent     " Copy indent from current line when starting a new line
set smartindent    " Do smart autoindenting when starting a new line
set copyindent     " Copy the structure of the existing lines indent
" --- Tab ---
set tabstop=8      " Width on the screen of the tab
set softtabstop=4  " Number of spaces in the file space is the corresponding
set expandtab      " Expand tabs to spaces (noexpandtab: No expand)
set shiftwidth=4   " Shift move width
set smarttab       " Indent by the number of 'shiftwidth'.
" --- Search ---
set hlsearch       " Highlight searches
nohlsearch         " Prevent the highlights when reload
set incsearch      " Do incremental searching
set ignorecase     " Ignore case when searching
set smartcase      " No ignorecase if Uppercase char present
" --- Statusline ---
set laststatus=2                " Always display status bar
let &statusline="%<%F%m%r%h%w%=[%{&ff}][%{&enc}][%{strlen(&ft)?&ft:'no\ ft'}]"
  \ . "%{printf('%'.(len(line('$'))+2).'d/%d',line('.'),line('$'))}%4v\ %P"
" --- Essential ---
filetype plugin indent on       " Load plugins according to detected filetype.
syntax on                       " Enable syntax highlight
try | colorscheme molokai | catch | colorscheme desert | endtry

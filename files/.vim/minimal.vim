" --- Init ---
set encoding=utf-8      " Sets the character encoding used inside Vim
scriptencoding utf-8    " Specify encoding used in the script
autocmd!
" --- Indent&Tab ---
set cindent        " Enables automatic C program indenting.
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
" --- Appearance ---
set ambiwidth=double                " Use twice the width of ASCII characters
set backspace=indent,eol,start      " Can erase everything in the back space
set clipboard=unnamed,unnamedplus   " Use the OS clipboard
set fileformats=unix,dos            " This gives the end-of-line formats
set helpheight=999                  " Open help to fill the screen
set history=200                     " History
set list listchars=tab:>-,trail:-   " Visualize character
set matchpairs& matchpairs+=<:>     " To support brackets a pair of '<' & '>'
set noerrorbells novisualbell t_vb= guioptions=M    " Turn off menu & bell
set noswapfile nobackup nowritebackup noundofile    " Doesn't make backup file
set tags=./tags;                    " Refer to projects root tags file
set ttimeout timeoutlen=300 ttimeoutlen=50  " Speedup for ESC
set wildmenu wildmode=list:full cmdheight=2 " Command-line
autocmd InsertLeave * set iminsert=0 imsearch=-1 nopaste    " IME off
" --- Statusline ---
set laststatus=2                    " Always display status bar
let &statusline="%<%F%m%r%h%w%=[%{&ff}][%{&enc}][%{strlen(&ft)?&ft:'no\ ft'}]"
  \ . "%{printf('%'.(len(line('$'))+2).'d/%d',line('.'),line('$'))}%4v\ %P"
" --- Grep ---
set wildignore+=*tags,*svg
let s:excludedir='*git,*venv*,.mypy_cache,.tox*,node_modules,.serverless,test-results'
let &grepprg='grep -irnIH --exclude-dir={' . s:excludedir . '}'
autocmd QuickFixCmdPost *grep* cwindow  " Auto open quickfix-window
" --- KeyMapping ---
" To Enable filtering the command history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" Like CTRL-], but use ":tjump" instead of ":tag".
nnoremap <C-]> g<C-]>zz
" --- Essential ---
filetype plugin indent on   " Load plugins according to detected filetype.
syntax on                   " Enable syntax highlight
try | colorscheme molokai | catch | colorscheme desert | endtry

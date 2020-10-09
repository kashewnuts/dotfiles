" --- Init ---
set encoding=utf-8      " Sets the character encoding used inside Vim
scriptencoding utf-8    " Specify encoding used in the script
autocmd!
" --- Essential ---
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim
try | colorscheme molokai | catch | colorscheme desert | endtry
let g:loaded_matchparen = 1
" --- Indent&Tab ---
set cindent        " Enables automatic C program indenting.
set tabstop=8      " Width on the screen of the tab
set softtabstop=4  " Number of spaces in the file space is the corresponding
set expandtab      " Expand tabs to spaces (noexpandtab: No expand)
set shiftwidth=4   " Shift move width
set smarttab       " Indent by the number of 'shiftwidth'.
" --- Appearance ---
set ambiwidth=double                " Use twice the width of ASCII characters
set clipboard=unnamed,unnamedplus   " Use the OS clipboard
set fileformats=unix,dos            " This gives the end-of-line formats
set list listchars=tab:>-,trail:-   " Visualize character
set matchpairs& matchpairs+=<:>,「:」,【:】,『:』,《:》,〈:〉,（:） " Add support brackets
set noerrorbells novisualbell t_vb= guioptions=M    " Turn off menu & bell
set noswapfile nobackup nowritebackup       " Doesn't make backup file
set ttimeout timeoutlen=300 ttimeoutlen=50  " Speedup for ESC
set wildmenu wildmode=list:full cmdheight=2 " Command-line
set laststatus=2                    " Always display status bar
let &statusline="%<%F%m%r%h%w%=[%{&ff}][%{&enc}][%{strlen(&ft)?&ft:'no\ ft'}]"
\ . "%{printf('%'.(len(line('$'))+2).'d/%d',line('.'),line('$'))}%4v\ %P"
autocmd InsertLeave * set iminsert=0 imsearch=-1 nopaste    " IME off
" --- Search ---
set hlsearch       " Highlight searches
nohlsearch         " Prevent the highlights when reload
set ignorecase     " Ignore case when searching
set smartcase      " No ignorecase if Uppercase char present
set path=**
set tags=./tags;   " Refer to projects root tags file
set wildignore& wildignore+=*tags,*svg,*bundle*.js,*png,*jpeg,*jpg
let s:excludedir='*git,*venv*,node_modules,static_files,tmp,dist*'
\ . ',*mypy_cache,*tox*,*.serverless,test-results,screenshots,locale'
let &grepprg='grep -rnIH --exclude-dir={' . s:excludedir . '}'
autocmd QuickFixCmdPost *grep* cwindow  " Auto open quickfix-window
" --- KeyMapping ---
nnoremap <C-p> :find<SPACE>
" To Enable filtering the command history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" Like CTRL-], but use ":tjump" instead of ":tag".
nnoremap <C-]> g<C-]>zz

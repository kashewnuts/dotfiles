" ==========================================================================
" Vim Configuration
"
" Author:   Kashun YOSHIDA
" Platform: Windows, Linux, MacOSX
" NOTE:     To use this, copy to your home directory.
" ==========================================================================

" Basic Settings {{{
if !1 | finish | endif          " Skip if the live Vim is vim-tiny or vim-small

" Encoding {{{
if has('win32') && !has('gui_running')
  let &termencoding = &encoding
  set encoding=cp932
else
  set encoding=utf-8            " Sets the character encoding used inside Vim
endif
scriptencoding utf-8            " Specify encoding used in the script
set fileformats=unix,dos,mac    " This gives the end-of-line (<EOL>) formats
" }}}

" Disable {{{
set guioptions=Mc                     " Disable menu.vim & Use console dialog
set noerrorbells novisualbell t_vb=   " Disable annoying bells
set noswapfile nobackup nowritebackup " Doesn't generate backup files
set noloadplugins                     " Disable the loading of plugins.

" Don't read $VIM/(g)vimrc
if has('kaoriya')
  function! s:disable_source(vimrc_local, message)
    let l:vimrc_local = expand($VIM . '/' . a:vimrc_local)
    if !filereadable(l:vimrc_local)
      execute ':redir! >' . l:vimrc_local
      silent! echon a:message
      redir END
    endif
  endfunction
  call s:disable_source('vimrc_local.vim',  'let g:vimrc_local_finish = 1')
  call s:disable_source('gvimrc_local.vim', 'let g:gvimrc_local_finish = 1')
endif " }}}
" }}}

" Misc {{{
" Appearance
set ambiwidth=double            " Use twice the width of ASCII characters
set display=lastline            " Enable view long line
set fillchars=vert:\|,fold:\    " Characters to fill the separators
set guifont=Ricty\ Diminished:h11
set helpheight=999              " Open help to fill the screen
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
set expandtab      " No expand tabs to spaces (expandtab: expand)
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

" Terminal
if !has('gui_running')
  set lazyredraw                  " Only redraw when necessary.
  set ttyfast                     " Faster redrawing.
  set timeout timeoutlen=1000 ttimeoutlen=50  " Speedup for ESC
endif
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

" To Enable filtering the command history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Even text wrapping movement by j or k, is modified to act naturally.
nnoremap j gj
nnoremap k gk
" }}}

" ReOpen Encoding {{{
command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! Utf8 edit ++enc=utf-8
command! Jis Iso2022jp
command! Sjis Cp932
" }}}

" FileType {{{
augroup MyAutoCmd
  autocmd!
  " Grep
  autocmd QuickFixCmdPost *grep* cwindow " Auto open quickfix-window

  " FileType {{{
  " ts   : tabstop
  " sw   : shiftwidth
  " sts  : softtabstop
  " et   : expandtab
  " noet : noexpandtab
  " si   : smartindent
  " cinw : cinwords
  autocmd FileType html       setl ts=4 sw=4 sts=4 et
  autocmd FileType htmldjango setl ts=2 sw=2 sts=2 et
  autocmd FileType javascript setl ts=4 sw=4 sts=4 et
  autocmd FileType ruby       setl ts=2 sw=2 sts=2 et
  autocmd FileType go         setl ts=4 sw=4 sts=4 noet
  autocmd FileType vim        setl ts=2 sw=2 sts=2 et
  autocmd FileType toml       setl ts=2 sw=2 sts=2 et
  autocmd FileType make       setl ts=4 sw=4 sts=4 noet
  autocmd FileType rst        setl ts=4 sw=4 sts=4 et
  autocmd FileType text       setl ts=4 sw=4 sts=4 et ft=markdown
  autocmd FileType gitconfig  setl ts=4 sw=4 sts=4 noet
  autocmd FileType jsp        setl ts=4 sw=4 sts=4 noet
  autocmd FileType java       setl ts=4 sw=4 sts=4 noet
  autocmd FileType python     setl ts=4 sw=4 sts=4 et textwidth=80
  autocmd FileType sql        setl ts=4 sw=4 sts=4 et fenc=shift_jis ff=dos
  " }}}

  " When the '#' character in the first line of the newly created,
  " it isn't unindent
  autocmd FileType python inoremap # X#
augroup END

" Golang settings {{{
if executable('go') && !executable('jvgrep')
  execute '!go get github.com/mattn/jvgrep'
endif
if executable('jvgrep')
  " Present Garbled characters
  if has('win32') && !has('gui_running')
    set grepprg=jvgrep\ -iIR
  else
    set grepprg=jvgrep\ -8iIR
  endif
endif " }}}

" Java settings {{{
" Syntax highlight
let g:java_highlight_all       = 1
let g:java_highlight_debug     = 1
let g:java_allow_cpp_keywords  = 1
let g:java_space_errors        = 1
let g:java_highlight_functions = 1
" }}}

" PHP settings {{{
let g:php_baselib       = 1
let g:php_htmlInStrings = 1
let g:php_noShortTags   = 1
let g:php_sql_query     = 1
" }}}
" }}}

" After Vim7.4 {{{
if exists('&undofile') | set noundofile | endif  " Don't make *.un~ files
if exists('&nofixeol') | set nofixeol | endif
if exists('&breakindent') | set breakindent | endif
" }}}

" dein.vim {{{
let s:toml_path = '~/.vim/rc/dein.toml'
let s:toml_lazy_path = '~/.vim/rc/dein_lazy.toml'
if v:version >= 704
      \ && executable('git')
      \ && executable('rsync')
      \ && filereadable(expand(s:toml_path))
      \ && filereadable(expand(s:toml_lazy_path))

  " dein configurations.
  let g:dein#install_progress_type = 'title'
  let g:dein#install_message_type = 'none'
  let g:dein#enable_notification = 1

  " Begin dein.vim
  let s:root_dein_path = expand('~/.cache/dein')
  let s:dein_dir = s:root_dein_path . '/repos/github.com/Shougo/dein.vim'
  if !isdirectory(s:dein_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
  endif
  set runtimepath^=~/.cache/dein/repos/github.com/Shougo/dein.vim

  " Read TOML & cache
  if dein#load_state(s:root_dein_path)
    call dein#begin(s:root_dein_path, [$MYVIMRC, s:toml_path, s:toml_lazy_path])
    call dein#load_toml(s:toml_path, {'lazy': 0})
    call dein#load_toml(s:toml_lazy_path, {'lazy' : 1})
    call dein#end()
    call dein#save_state()
  endif

  if !has('vim_starting') && dein#check_install()
    " Installation check.
    call dein#install()
  endif
endif " }}}

" Others {{{
" Essential
filetype plugin indent on       " Load plugins according to detected filetype.
syntax on                       " Enable syntax highlight

" Colorscheme
try
  if has('win32') && !has('gui_running')
    colorscheme industry
  else
    colorscheme molokai
  endif
catch
  try | colorscheme desert | catch | endtry
endtry

" Load local settings
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
set secure                      " Safely use Vim
" }}}

" vim: tw=78 et sw=2 foldmethod=marker

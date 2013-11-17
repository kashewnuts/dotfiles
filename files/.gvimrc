" ==============================================================================
" Vim GUI settings
"
" Maintainer   : Kashun YOSHIDA
" To use this, copy to your home directory.
" ==============================================================================

let s:is_windows = has("win16") || has("win32") || has("win64")
let s:is_darwin = has("mac") || has("macunix") || has("gui_macvim")

colorscheme adrian

set guioptions-=T  " Disable Toolbar
set guioptions-=m  " Disable Menu bar

" Menu UTF-8 Setting
if s:is_windows
  set guifont=MS_Gothic:h12
  source $VIMRUNTIME/delmenu.vim
  set langmenu=ja_jp.utf-8
  source $VIMRUNTIME/menu.vim
endif

" Display full-width space
highlight ZenkakuSpace cterm=underline ctermfg=LightBlue guibg=DarkBlue
match ZenkakuSpace /　/

" Hack #120: Store the location and size of the window by gVim
let g:save_window_file = expand("~/.vimwinpos")
augroup SaveWindow
  autocmd!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
    let options = [
      \ "set columns=" . &columns,
      \ "set lines=" . &lines,
      \ "winpos " . getwinposx() . " " . getwinposy(),
      \ ]
    call writefile(options, g:save_window_file)
  endfunction
augroup END

if filereadable(g:save_window_file)
  execute "source" g:save_window_file
endif

" ime setting
if has("multi byte_ime") || has("xim") || has("gui_macvim")
  " Insert , Search mode: ime setting
  set iminsert=2
  set imsearch=2
  " Normal mode: IME off
  inoremap <silent> <Esc><Esc>:set iminsert=0<CR>
endif

" semitransparency
if s:is_windows
  gui
  set transparency=220
elseif s:is_darwin
  set transparency=20
endif

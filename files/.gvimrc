" ==============================================================================
" Vim GUI Configuration
"
" Author:   Kashun YOSHIDA
" Platform: Windows, Linux, MacOSX
" NOTE:     To use this, copy to your home directory.
" ==============================================================================

" Basic Settings {{{
let s:is_windows = has("win16") || has("win32") || has("win64")
let s:is_darwin = has("mac") || has("macunix") || has("gui_macvim")

" guioptions
set guioptions-=T  " Disable Toolbar
set guioptions-=m  " Disable Menu bar

" Font
if s:is_windows
  set guifont=MS_Gothic:h10
endif
" }}}

" Hack #120: Store the location and size of the window by gVim {{{
let s:save_window_file = expand("~/.vimwinpos")
augroup SaveWindow
  autocmd!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
    let options = [
      \ "set columns=" . &columns,
      \ "set lines=" . &lines,
      \ "winpos " . getwinposx() . " " . getwinposy(),
      \ ]
    call writefile(options, s:save_window_file)
  endfunction
augroup END

if filereadable(s:save_window_file)
  execute "source" s:save_window_file
endif
" }}}

" IME setting {{{
if has("multi byte_ime") || has("xim") || has("gui_macvim")
  " Insert , Search mode: ime setting
  set iminsert=2
  set imsearch=2
  " Normal mode: IME off
  inoremap <silent> <Esc><Esc>:set iminsert=0<CR>
endif " }}}

" Semitransparency {{{
if s:is_windows
  gui
  set transparency=220
elseif s:is_darwin
  set transparency=20
endif " }}}

" Local settings {{{
let s:localrc = expand('~/.gvimrc.local')
if filereadable(s:localrc)
  source ~/.gvimrc.local
endif " }}}

" vim: expandtab softtabstop=2 shiftwidth=2

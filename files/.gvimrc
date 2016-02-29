" ==============================================================================
" Vim GUI Configuration
"
" Author:   Kashun YOSHIDA
" Platform: Windows, Linux, MacOSX
" NOTE:     To use this, copy to your home directory.
" ==============================================================================

" guioptions {{{
set guioptions-=T  " Disable Toolbar
set guioptions-=m  " Disable Menu bar
" }}}

" Env {{{
let s:env = VimrcEnvironment()
" }}}

" ColorScheme {{{
if has('gui_running')
  colorscheme desert
endif
" }}}

" Font {{{
if s:env.is_windows
  set guifont=MeiryoKe_Gothic:h10,MS_Gothic:h10
elseif s:env.is_darwin
  set guifont=Osaka-Mono:h14
endif
" }}}

" Hack #120: Store the location and size of the window by gVim {{{
let s:save_window_file = expand('~/.vimwinpos')
augroup SaveWindow
  autocmd!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
    let options = [
      \ 'set columns=' . &columns,
      \ 'set lines=' . &lines,
      \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
      \ ]
    call writefile(options, s:save_window_file)
  endfunction
augroup END

if filereadable(s:save_window_file)
  execute 'source' s:save_window_file
endif
" }}}

" IME setting {{{
if s:env.is_ime
  " Insert , Search mode: ime setting
  set iminsert=2
  set imsearch=2
  " Normal mode: IME off
  inoremap <silent> <Esc><Esc>:set iminsert=0<CR>
endif " }}}

" Semitransparency {{{
if s:env.is_windows
  gui
  set transparency=220
elseif s:env.is_darwin
  set transparency=20
endif " }}}

" Local settings {{{
let s:localrc = expand('~/.gvimrc.local')
if filereadable(s:localrc)
  source ~/.gvimrc.local
endif " }}}

" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker

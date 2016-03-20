" ==============================================================================
" Vim GUI Configuration
"
" Author:   Kashun YOSHIDA
" Platform: Windows, Linux, MacOSX
" NOTE:     To use this, copy to your home directory.
" ==============================================================================

" Env {{{
let s:env = VimrcEnvironment() " }}}

" Font {{{
set guifont=MeiryoKe_Gothic:h10,MS_Gothic:h10,Osaka-Mono:h14
" }}}

" ColorScheme {{{
if has('gui_running')
  colorscheme desert
endif " }}}

" Hack #120: Store the location and size of the window by gVim {{{
if has('gui_running')
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
endif " }}}

" Semitransparency {{{
if s:env.IsWindows
  au MyAutoCmd GUIEnter * set transparency=220
elseif s:env.IsDarwin
  set transparency=20
endif " }}}

" Local settings {{{
let s:localrc = expand('~/.gvimrc.local')
if filereadable(s:localrc)
  source ~/.gvimrc.local
endif " }}}

" vim: tw=78 et sw=2 foldmethod=marker

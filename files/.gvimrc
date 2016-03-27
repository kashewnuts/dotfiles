" ==========================================================================
" Vim GUI Configuration
"
" Author:   Kashun YOSHIDA
" Platform: Windows, Linux, MacOSX
" NOTE:     To use this, copy to your home directory.
" ==========================================================================

function! VimrcEnvironment() " {{{
  let s:env = {}
  let s:env.IsWindows = has('win16') || has('win32') || has('win64')
  let s:env.IsDarwin  = has('mac') || has('macunix') || has('gui_macvim')
  let s:env.IsIme     = has('multi byte_ime') || has('xim') || has('gui_macvim')
  return s:env
endfunction
let s:env = VimrcEnvironment() " }}}

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
  augroup Semitransparency
    au!
    au GUIEnter * set transparency=220
  augroup END
elseif s:env.IsDarwin
  set transparency=20
endif " }}}

" Local settings {{{
let s:localrc = expand('~/.gvimrc.local')
if filereadable(s:localrc)
  source ~/.gvimrc.local
endif " }}}

" vim: tw=78 et sw=2 foldmethod=marker

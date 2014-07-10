" ==============================================================================
" Vim Configuration
"
" Author:   Kashun YOSHIDA
" Platform: Windows, Linux, MacOSX
" NOTE:     To use this, copy to your home directory.
" ==============================================================================
"
" Release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

" load_source
function! s:load_source(path)
  let path = expand(a:path)
  if filereadable(path)
    execute "source " . path
  endif
endfunction

" Plugins
call s:load_source(expand('~/dotfiles/files/.vimrc.plugins'))
" Basic
call s:load_source(expand('~/dotfiles/files/.vimrc.basic'))
" Filetype
call s:load_source(expand('~/dotfiles/files/.vimrc.filetype'))
" Other
call s:load_source(expand('~/dotfiles/files/.vimrc.misc'))
" Local
call s:load_source(expand('~/.vimrc.local'))

" vim: expandtab softtabstop=2 shiftwidth=2 ft=vim

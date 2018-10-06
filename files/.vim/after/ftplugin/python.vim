setlocal ts=4 sts=4 sw=4
setlocal textwidth=99
" When the '#' character in the first line of the newly created,
" it isn't unindent
inoremap # X#

augroup python_syntax_extra
  autocmd!
  autocmd Syntax python :syn keyword Special self cls
  autocmd Syntax python :hi link pythonSpecialWord    Special
  autocmd Syntax python :syn match pythonOperator '\V=\|-\|+\|*\|@\|/\|%\|&\||\|^\|~\|<\|>\|!='
  " autocmd Syntax python :syn match pythonDelimiter "\(,\|\.\|:\)"
  " autocmd Syntax python :hi link pythonDelimiter      Special
augroup END


if executable('autopep8') | setlocal equalprg=autopep8\ - | endif

" autocmd! User jedi-vim call s:jedivim_hook() " {{{
" function! s:jedivim_hook()
"   let g:jedi#auto_initialization    = 0 " Disable the default initialization routine
"   let g:jedi#auto_vim_configuration = 0 " Don't change 'completeopt'
"   let g:jedi#popup_on_dot           = 0 " Manually press the completion key
"   let g:jedi#popup_select_first     = 0 " Don't select first completion entry
"   let g:jedi#show_call_signatures   = 0 " Avoid popups bugs
"   " autocmd MyAutoCmd FileType python setlocal omnifunc=jedi#completions
" endfunction
" let g:jedi#goto_command = '<C-]>'

" " Since the default mapping doesn't work, it define with a command.
" command! Jdoc call jedi#show_documentation()
" command! Jgoto call jedi#goto()
" function! JediRename()
"   call jedi#clear_cache(0)
"   call jedi#rename()
" endfunction
" command! Jrename call JediRename()
" command! Jusages call jedi#usages()
" }}}

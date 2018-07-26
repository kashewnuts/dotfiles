setlocal ts=4 sts=4 sw=4
setlocal textwidth=99
" When the '#' character in the first line of the newly created,
" it isn't unindent
inoremap # X#
if executable('autopep8') | setlocal equalprg=autopep8\ - | endif

autocmd! User jedi-vim call s:jedivim_hook() " {{{
function! s:jedivim_hook()
  let g:jedi#auto_initialization    = 0 " Disable the default initialization routine
  let g:jedi#auto_vim_configuration = 0 " Don't change 'completeopt'
  let g:jedi#popup_on_dot           = 0 " Manually press the completion key
  let g:jedi#popup_select_first     = 0 " Don't select first completion entry
  let g:jedi#show_call_signatures   = 0 " Avoid popups bugs
  " Disable default mapping
  " let g:jedi#documentation_command = ''
  " let g:jedi#goto_assignments_command = ''
  " let g:jedi#goto_command = ''
  " let g:jedi#goto_definitions_command = ''
  " let g:jedi#rename_command = ''
  " let g:jedi#usages_command = ''
  autocmd MyAutoCmd FileType python setlocal omnifunc=jedi#completions
endfunction
" let g:jedi#goto_command = '<C-]>'

" Since the default mapping doesn't work, it define with a command.
command! Jdoc call jedi#show_documentation()
command! Jgoto call jedi#goto()
function! JediRename()
  call jedi#clear_cache(0)
  call jedi#rename()
endfunction
command! Jrename call JediRename()
command! Jusages call jedi#usages()
" }}}

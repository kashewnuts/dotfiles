setlocal ts=4 sts=4 sw=4
setlocal textwidth=99
" When the '#' character in the first line of the newly created,
" it isn't unindent
inoremap # X#
if executable('autopep8') | setlocal equalprg=autopep8\ - | endif

augroup python_syntax_extra
  autocmd!
  autocmd Syntax python :syn keyword Special self cls
  autocmd Syntax python :hi link pythonSpecialWord    Special
  autocmd Syntax python :syn match pythonOperator '\V=\|-\|+\|*\|@\|/\|%\|&\||\|^\|~\|<\|>\|!='
augroup END

" --- python-syntax --- {{{
let g:python_highlight_all = 1
" }}}

" --- jedi-vim --- {{{
augroup PythonAutoCmd
  autocmd!
  autocmd User jedi-vim call s:jedivim_hook() " {{{
  " autocmd FileType python setlocal omnifunc=jedi#completions
  function! s:jedivim_hook()
    let g:jedi#completions_enabled    = 0 " For vim-lsp
    let g:jedi#auto_initialization    = 0 " Disable the default initialization routine
    let g:jedi#auto_vim_configuration = 0 " Don't change 'completeopt'
    let g:jedi#popup_on_dot           = 0 " Manually press the completion key
    let g:jedi#popup_select_first     = 0 " Don't select first completion entry
    let g:jedi#show_call_signatures   = 0 " Avoid popups bugs
  endfunction
  let g:jedi#goto_command = '<C-]>'
augroup END " }}}

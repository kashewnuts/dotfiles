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

augroup FileTypeAutoCmd
  au!
  " Grep
  au QuickFixCmdPost *grep* cwindow " Auto open quickfix-window

  " FileType {{{
  " ts   : tabstop
  " sw   : shiftwidth
  " sts  : softtabstop
  " et   : expandtab
  " noet : noexpandtab
  " si   : smartindent
  " cinw : cinwords
  au FileType html       setl ts=4 sw=4 sts=4 et
  au FileType htmldjango setl ts=2 sw=2 sts=2 et
  au FileType javascript setl ts=4 sw=4 sts=4 et
  au FileType ruby       setl ts=2 sw=2 sts=2 et
  au FileType go         setl ts=4 sw=4 sts=4 noet
  au FileType vim        setl ts=2 sw=2 sts=2 et
  au FileType make       setl ts=4 sw=4 sts=4 noet
  au FileType text       setl ts=4 sw=4 sts=4 et ft=rst
  au FileType rst        setl ts=4 sw=4 sts=4 et
  au FileType gitconfig  setl ts=4 sw=4 sts=4 noet
  au FileType jsp        setl ts=4 sw=4 sts=4 noet
  au FileType java       setl ts=4 sw=4 sts=4 noet
  au FileType python     setl ts=4 sw=4 sts=4 et textwidth=80
  au FileType sql        setl ts=4 sw=4 sts=4 et fenc=shift_jis ff=dos
  au FileType scp        setl ts=4 sw=4 sts=4 noet fenc=shift_jis ff=dos
  au FileType scp        setl dictionary='~/.vim/dict/scp.dict' suffixesadd+=.scp
  " }}}

  " When the '#' character in the first line of the newly created,
  " it isn't unindent
  au FileType python inoremap # X#
  au BufNewFile *.py 0r ~/.vim/template/python.txt
augroup END

" Golang settings {{{
if $GOROOT !=# '' | set grepprg=jvgrep | endif " }}}

" Java settings {{{
" Syntax highlight
let g:java_highlight_all       = 1
let g:java_highlight_debug     = 1
let g:java_allow_cpp_keywords  = 1
let g:java_space_errors        = 1
let g:java_highlight_functions = 1
" }}}

" PHP settings {{{
let g:php_baselib       = 1
let g:php_htmlInStrings = 1
let g:php_noShortTags   = 1
let g:php_sql_query     = 1
" }}}

" vim: tw=78 et sw=2 foldmethod=marker

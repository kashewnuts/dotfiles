augroup MyAutoCmd
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
  " Auto Fmt
  au BufWritePre *.go Fmt
augroup END

" silent! filetype plugin indent on
" filetype detect

" vim: tw=78 et sw=2 foldmethod=marker

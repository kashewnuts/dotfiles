setlocal ts=2 sts=2 sw=2
augroup HTMLAutoCmd
  autocmd!
  " autocmd FileType html setf=htmldjango
  " autocmd BufNewFile,BufRead *.html setlocal filetype=htmldjango
  autocmd FileType htmldjango inoremap {% {% %}<left><left><left>
  autocmd FileType htmldjango inoremap {{ {{ }}<left><left><left>
augroup END

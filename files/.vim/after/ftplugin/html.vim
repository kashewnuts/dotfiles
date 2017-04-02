setlocal ts=2 sts=2 sw=2
autocmd MyAutoCmd FileType html setf=htmldjango
autocmd MyAutoCmd BufNewFile,BufRead *.html setlocal filetype=htmldjango
autocmd MyAutoCmd FileType htmldjango inoremap {% {% %}<left><left><left>
autocmd MyAutoCmd FileType htmldjango inoremap {{ {{ }}<left><left><left>

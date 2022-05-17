setlocal noexpandtab
setlocal tabstop=4

" For vim-go
function! s:build_go_files()
  " run :GoBuild or :GoTestCompile based on the go file
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
augroup GolangAutoCmd
  autocmd!
  " autocmd FileType go nmap <leader>b  <Plug>(go-build)
  autocmd FileType go noremap <leader>b :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go noremap <leader>r  <Plug>(go-run)
  autocmd FileType go noremap <leader>t  <Plug>(go-test)
  autocmd FileType go noremap <Leader>c  <Plug>(go-coverage-toggle)
  autocmd FileType go noremap <Leader>i  <Plug>(go-info)
augroup END

let g:go_list_type = 'quickfix'
let g:go_fmt_command = 'goimports'  " Auto run goimports
" let g:go_auto_sameids = 1   " Auto highlight

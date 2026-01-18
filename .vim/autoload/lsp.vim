" ==========================================================================
" LSP (coc.nvim) Configuration
" ==========================================================================

let s:coc_filetypes = [
  \ 'Dockerfile',
  \ 'bash',
  \ 'conf',
  \ 'css',
  \ 'go',
  \ 'html',
  \ 'javascript',
  \ 'jsx',
  \ 'json',
  \ 'markdown',
  \ 'python',
  \ 'scss',
  \ 'terraform',
  \ 'tf',
  \ 'typescript',
  \ 'typescriptreact',
  \ 'vue',
  \ 'yaml',
  \ 'sql',
  \ ]

function! lsp#Configure() abort
  if match(s:coc_filetypes, &filetype) == -1
    return
  endif

  " Remap keys
  nmap <buffer><C-]> <Plug>(coc-definition)
  nmap <buffer><silent> gy <Plug>(coc-type-definition)
  nmap <buffer><silent> gi <Plug>(coc-implementation)
  nmap <buffer><silent> gr <Plug>(coc-references)
  nmap <buffer><leader>R   <Plug>(coc-rename)
  " Remap for format selected region
  xmap <buffer><leader>f   <Plug>(coc-format-selected)
  vmap <buffer><leader>f   <Plug>(coc-format-selected)
  nmap <buffer><leader>f   <Plug>(coc-format-selected)
  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  vmap <buffer><leader>a   <Plug>(coc-codeaction-selected)
  nmap <buffer><leader>a   <Plug>(coc-codeaction-selected)
  " Remap for do codeAction of current line
  nmap <buffer><leader>ac  <Plug>(coc-codeaction)
  " Fix autofix problem of current line
  nmap <buffer><leader>qf  <Plug>(coc-fix-current)
  " Diagnostic
  nmap <buffer><silent> gd <Plug>(coc-diagnostic-info)
  nmap <buffer><silent> gn <Plug>(coc-diagnostic-next)
  nmap <buffer><silent> gp <Plug>(coc-diagnostic-prev)
  " Setup format selected region
  setlocal formatexpr=CocAction('formatSelected')
  " coc-git
  highlight default link GitGutterAdd           NONE
  highlight default link GitGutterChange        NONE
  highlight default link GitGutterDelete        NONE
  highlight default link GitGutterChangeDelete  NONE
  " Use K to show documentation in preview window
  nnoremap <silent> K :call lsp#ShowDocumentation()<CR>

  augroup CocNvimGroup
    autocmd!
    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  command! -nargs=0 Prettier :CocCommand prettier.formatFile
  " Add `:Format` command to format current buffer
  command! -nargs=0 Format :call CocActionAsync('format')
  " Add `:OR` command for organize imports of the current buffer
  command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')
endfunction

function! lsp#ShowDocumentation() abort
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" vim: tw=78 et sw=2 foldmethod=marker

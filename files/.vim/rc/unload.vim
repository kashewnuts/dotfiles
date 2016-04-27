" Disable the loading of plugins.
set noloadplugins

" STOP default plugins
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_rrhelper          = 1
let g:loaded_2html_plugin      = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_LogiPat           = 1
let g:loaded_logipat           = 1
let g:plugin_autodate_disable  = 1
let g:plugin_cmdex_disable     = 1
let g:plugin_dicwin_disable    = 1
let g:plugin_format_disable    = 1
let g:plugin_hz_ja_disable     = 1
let g:plugin_scrnmode_disable  = 1
let g:plugin_verifyenc_disable = 1

if has('kaoriya')
  " Don't read $VIM/(g)vimrc
  function! s:disable_source(vimrclocal, message)
    let l:path = expand($VIM . '/' . a:vimrclocal)
    if !filereadable(l:path)
      execute ':redir! >' . l:path
      silent! echon a:message
      redir END
    endif
  endfunction
  call s:disable_source('vimrc_local.vim',  'let g:vimrc_local_finish = 1')
  call s:disable_source('gvimrc_local.vim', 'let g:gvimrc_local_finish = 1')
endif

" vim: tw=78 et sw=2 foldmethod=marker

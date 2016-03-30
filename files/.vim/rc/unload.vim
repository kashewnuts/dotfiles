" guioptions
set guioptions+=M               " Disable menu.vim
set guioptions-=T               " Disable Toolbar
set guioptions-=m               " Disable Menu bar

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

if !(has('unix') && !has('mac'))
  " Don't Read $VIM/vimrc
  let s:vimrclocal = '$VIM/vimrc_local.vim'
  if !filereadable(s:vimrclocal)
    execute ':redir! >'. s:vimrclocal
    silent! echon 'let g:vimrc_local_finish = 1'
    redir END
  endif

  " Don't Read $VIM/gvimrc
  let s:gvimrclocal = '$VIM/gvimrc_local.vim'
  if !filereadable(s:gvimrclocal)
    execute ':redir! >'. s:gvimrclocal
    silent! echon 'let g:gvimrc_local_finish = 1'
    redir END
  endif
endif

" vim: tw=78 et sw=2 foldmethod=marker

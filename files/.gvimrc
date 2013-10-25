" ==============================================================================
" Vim GUI settings
"
" Maintainer   : Kashun YOSHIDA
" To use this, copy to your home directory.
" ==============================================================================

let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_darwin = has('mac') || has('macunix') || has('gui_macvim')

if s:is_windows
  setl guifont=MS_Gothic:h12
  source $VIMRUNTIME/delmenu.vim " Menu UTF-8 Setting
  setl langmenu=ja_jp.utf-8
  source $VIMRUNTIME/menu.vim
elseif s:is_darwin
  setl transparency=20
endif

colorscheme adrian

setl guioptions-=T  " Disable Toolbar
setl guioptions-=m  " Disable Menu bar

" Display full-width space
highlight ZenkakuSpace cterm=underline ctermfg=LightBlue guibg=DarkBlue
match ZenkakuSpace /　/

" Hack #120: Store the location and size of the window by gVim
let g:save_window_file = expand('~/.vimwinpos')
augroup SaveWindow 
  autocmd!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
    let options = [
      \ 'setl columns=' . &columns,
      \ 'setl lines=' . &lines,
      \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
      \ ]
    call writefile(options, g:save_window_file)
  endfunction
augroup END

if filereadable(g:save_window_file)
  execute 'source' g:save_window_file
endif

" ime setting
if has('multi byte_ime') || has('xim') || has('gui_macvim')
    " Insert , Search mode: ime setting
    setl iminsert=2
    setl imsearch=2
    " Normal mode: IME off
    inoremap <silent> <Esc><Esc>:setl iminsert=0<CR>
endif

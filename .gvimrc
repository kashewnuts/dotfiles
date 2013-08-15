" ==============================================================================
" Vim GUI settings
"
" Maintainer   : Kashun YOSHIDA
" To use this, copy to your home directory.
" ==============================================================================


colorscheme adrian " colorscheme 設定 (GUI使用時)

if has('gui_macvim')
    set transparency=20 " 背景透過設定
endif

set guioptions-=T  " ツールバーを非表示にする
set guioptions-=m  " メニューバーを非表示にする

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=LightBlue guibg=DarkBlue
match ZenkakuSpace /　/

" Hack #120: gVim でウィンドウの位置とサイズを記憶する
let g:save_window_file = expand('~/.vimwinpos')
augroup SaveWindow
  autocmd!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
    let options = [
      \ 'set columns=' . &columns,
      \ 'set lines=' . &lines,
      \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
      \ ]
    call writefile(options, g:save_window_file)
  endfunction
augroup END

if filereadable(g:save_window_file)
  execute 'source' g:save_window_file
endif

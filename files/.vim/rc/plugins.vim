" dein.vim
let s:toml_path = '~/.vim/rc/dein.toml'
let s:toml_lazy_path = '~/.vim/rc/dein_lazy.toml'
if v:version >= 704
      \ && executable('git')
      \ && executable('rsync')
      \ && filereadable(expand(s:toml_path))
      \ && filereadable(expand(s:toml_lazy_path))

  " dein configurations.
  let g:dein#install_progress_type = 'title'
  let g:dein#install_message_type = 'none'
  let g:dein#enable_notification = 1

  " Begin dein.vim
  let s:root_dein_path = expand('~/.cache/dein')
  let s:dein_dir = s:root_dein_path . '/repos/github.com/Shougo/dein.vim'
  if !isdirectory(s:dein_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
  endif
  set runtimepath^=~/.cache/dein/repos/github.com/Shougo/dein.vim

  " Read TOML & cache
  if dein#load_state(s:root_dein_path)
    call dein#begin(s:root_dein_path, [$MYVIMRC, s:toml_path, s:toml_lazy_path])
    call dein#load_toml(s:toml_path, {'lazy': 0})
    call dein#load_toml(s:toml_lazy_path, {'lazy' : 1})
    call dein#end()
    call dein#save_state()
  endif

  if !has('vim_starting') && dein#check_install()
    " Installation check.
    call dein#install()
  endif
endif " }}}

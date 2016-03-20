" Cache
let $CACHE = expand('~/.cache')
if !isdirectory(expand($CACHE))
  call mkdir(expand($CACHE), 'p')
endif

" Load dein.vim
if v:version >= 704 && isdirectory(expand('~/.vim'))
  " Begin dein.vim
  let s:dein_dir = finddir('dein.vim', '.;')
  if s:dein_dir !=# '' || &runtimepath !~# '/dein.vim'
    if s:dein_dir ==# '' && &runtimepath !~# '/dein.vim'
      let s:dein_dir = expand('$CACHE/dein') . '/repos/github.com/Shougo/dein.vim'

      if !isdirectory(s:dein_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
      endif
    endif
    set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
  endif
  let s:path = expand('~/.cache/dein')
  let s:toml_path = '~/.vim/rc/dein.toml'
  let s:toml_lazy_path = '~/.vim/rc/dein_lazy.toml'

  " Read TOML & cache
  if dein#load_state(s:path)
    call dein#begin(s:path)
    call dein#load_toml(s:toml_path, {'lazy': 0})
    call dein#load_toml(s:toml_lazy_path, {'lazy' : 1})
    call dein#end()
    call dein#save_state()
  endif

  let g:dein#types#git#clone_depth = 1
  " Install plugins to asynchronous
  if dein#check_install(['vimproc.vim'])
    call dein#install(['vimproc.vim'])
  endif
  if dein#check_install()
    call dein#install()
  endif
endif

" vim: tw=78 et sw=2 foldmethod=marker

" Plugin settings

if dein#tap('neocomplete.vim') " {{{
  let g:acp_enableAtStartup = 0            " NeoCompleteEnable
  let g:neocomplete#enable_smart_case = 1  " Use smartcase.

  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3

  " jedi omni completion
  au MyAutoCmd FileType python setl omnifunc=jedi#completions

  let g:jedi#auto_vim_configuration = 0
  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.python =
    \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
  let g:neocomplete#force_omni_input_patterns.go = '[^. \t]\.\w*'

  let g:neocomplete#sources#dictionary#dictionaries = {'default': ''}
  " let g:neocomplete#sources#dictionary#dictionaries = {
  "   \ 'default':    '',
  "   \ 'vimshell':   $HOME.'/.vimshell_hist',
  "   \ 'scala':      $HOME.'/.vim/bundle/vim-scala/dict/scala.dict',
  "   \ 'c':          $HOME.'/.vim/dict/c.dict',
  "   \ 'cpp':        $HOME.'/.vim/dict/cpp.dict',
  "   \ 'java':       $HOME.'/.vim/dict/java.dict',
  "   \ 'lua':        $HOME.'/.vim/dict/lua.dict',
  "   \ 'ocaml':      $HOME.'/.vim/dict/ocaml.dict',
  "   \ 'perl':       $HOME.'/.vim/dict/perl.dict',
  "   \ 'php':        $HOME.'/.vim/dict/php.dict',
  "   \ 'scheme':     $HOME.'/.vim/dict/scheme.dict',
  "   \ 'vim':        $HOME.'/.vim/dict/vim.dict'
  "   \ }

  " Enable omni completion.
  au MyAutoCmd FileType css setl omnifunc=csscomplete#CompleteCSS
  au MyAutoCmd FileType html,markdown setl omnifunc=htmlcomplete#CompleteTags
  au MyAutoCmd FileType javascript setl omnifunc=javascriptcomplete#CompleteJS
  au MyAutoCmd FileType xml setl omnifunc=xmlcomplete#CompleteTags
endif " }}}

if dein#tap('neocomplcache.vim') " {{{
  let g:acp_enableAtStartup = 0
  let g:neocomplcache_enable_smart_case = 1

  " jedi omni completion
  au MyAutoCmd FileType python setl omnifunc=jedi#completions
  let g:jedi#auto_vim_configuration = 0
  if !exists('g:neocomplcache_force_omni_patterns')
    let g:neocomplcache_force_omni_patterns = {}
  endif
  let g:neocomplcache_force_omni_patterns.python = '[^. \t]\.\w*'
endif " }}}

if dein#tap('neosnippet.vim') " {{{
  " Plugin key-mappings.
  imap <C-k>   <Plug>(neosnippet_expand_or_jump)
  smap <C-k>   <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>   <Plug>(neosnippet_expand_target)

  " SuperTab like snippets behavior.
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ '\<Plug>(neosnippet_expand_or_jump)'
        \: pumvisible() ? '\<C-n>' : '\<TAB>'
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ '\<Plug>(neosnippet_expand_or_jump)'
        \: '\<TAB>'

  " For snippet_complete marker.
  if has('conceal')
    set conceallevel=2 concealcursor=i
  endif

  " Enable snipMate compatibility feature.
  let g:neosnippet#enable_snipmate_compatibility = 1

  " Tell Neosnippet about the other snippets
  let g:neosnippet#snippets_directory=dein#tapir.'/vim-snippets/snippets'
endif " }}}

if dein#tap('vimfiler') " {{{
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_safe_mode_by_default = 0
  " close vimfiler automatically when there are only vimfiler open
  nnoremap <Leader>e :VimFilerExplorer<CR>
  au MyAutoCmd BufEnter * if (
      \ winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
endif " }}}

if dein#tap('vim-quickrun') " {{{
  nmap <Leader>r <Plug>(quickrun)
  " Open at the height of 10-digit buffer window by horizontal split at the bottom
  " Enable asynchronous processing
  " Disable the Sheban prevent garbled in a Windows environment
  let g:quickrun_config = {
  \  '_' : {
  \      'outputter/buffer/split' : ':botright 10sp',
  \      'runner' : 'vimproc',
  \      'hook/shebang/enable' : 0,
  \  }
  \ }
endif " }}}

if dein#tap('jedi-vim') " {{{
  let g:jedi#auto_initialization = 0
  let g:jedi#rename_command = '<leader>R'
  let g:jedi#popup_on_dot = 1
  let g:jedi#show_call_signatures = 0
  let g:jedi#popup_select_first = 0
  au MyAutoCmd FileType python let b:did_ftplugin = 1
  au MyAutoCmd FileType python setl completeopt-=preview " disable docstring
endif " }}}

if dein#tap('vim-flake8') " {{{
  au MyAutoCmd BufWritePost *.py call Flake8()
endif " }}}

if dein#tap('Align') " {{{
  let g:Align_xstrlen = 3       " for japanese string
  let g:DrChipTopLvlMenu = ''   " remove 'DrChip' menu
endif " }}}

if dein#tap('simplenote.vim') " {{{
  let s:env = VimrcEnvironment()
  if s:env.is_windows
    let g:SimplenoteListHeight=50
  else
    let g:SimplenoteListHeight=35
  endif
  let g:SimplenoteFiletype ='rst'
endif " }}}

if dein#tap('emmet-vim') " {{{
  let g:user_emmet_settings = {
  \  'php' : { 'extends' : 'html', 'filters' : 'c', },
  \  'xml' : { 'extends' : 'html', },
  \  'haml': { 'extends' : 'html', },
  \ }
endif " }}}

if dein#tap('TweetVim') " {{{
  let g:tweetvim_display_time = 1
  let g:tweetvim_async_post = 1
endif " }}}

if dein#tap('vim-trailing-whitespace') " {{{
  let g:extra_whitespace_ignored_filetypes = ['unite']
endif " }}}

" vim: tw=78 et st=2 sw=2 foldmethod=marker

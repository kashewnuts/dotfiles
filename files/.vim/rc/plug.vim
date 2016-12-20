" vim-plug

" Skip if requirements are not satisfied {{{
if !(executable('curl') && executable('git'))
  finish
endif " }}}

" Plugins List {{{
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
" FuzzyFinder
Plug 'ctrlpvim/ctrlp.vim'
if (v:version >= 800 || has('nvim')) && has('python3')
  Plug 'Shougo/denite.nvim' | Plug 'Shougo/neomru.vim'
endif
" Snippets
Plug 'Shougo/context_filetype.vim',     {'on': []}
Plug 'Shougo/neosnippet-snippets',      {'on': []}
Plug 'Shougo/neosnippet.vim',           {'on': []}
" thinca Plugins
Plug 'thinca/vim-fontzoom',             {'on': ['<Plug>(fontzoom-larger)', '<Plug>(fontzoom-smaller)']}
Plug 'thinca/vim-ft-rst_header',        {'for': 'rst'}
" Web
Plug 'othree/html5.vim',                {'for': ['html', 'css', 'javascript', 'jinja', 'htmljinja']}
Plug 'mattn/emmet-vim',                 {'for': ['html', 'css', 'ruby', 'php', 'haml', 'xml']}
" Git
Plug 'lambdalisue/vim-gista',           {'on': 'Gista'}
Plug 'cohama/agit.vim',                 {'on': 'Agit'}
" Edit
Plug 'bronson/vim-trailing-whitespace', {'on':  'FixWhitespace'}
Plug 'fatih/vim-go',                    {'for': 'go'}
Plug 'glidenote/memolist.vim',          {'on': ['MemoGrep', 'MemoList', 'MemoNew']}
Plug 'tyru/caw.vim',                    {'on': ['<Plug>(caw:prefix)', '<Plug>(caw:hatpos:toggle)']}
" Formater
Plug 'junegunn/vim-easy-align',         {'on': '<Plug>(EasyAlign)'}
let b:AligCommands = ['Align', 'SQLUFormatter']
Plug 'vim-scripts/Align',               {'on': b:AligCommands}
Plug 'vim-scripts/SQLUtilities',        {'on': b:AligCommands}
unlet b:AligCommands
" Reference & View
Plug 'kannokanno/previm',               {'on': 'PrevimOpen'}
Plug 'vim-jp/vimdoc-ja'
" Twitter
let b:TweetVimCommands = ['TweetVimSay', 'TweetVimSearch', 'TweetVimMentions', 'TweetVimCurrentLineSay']
Plug 'basyura/TweetVim',                {'on': b:TweetVimCommands}
Plug 'basyura/twibill.vim',             {'on': b:TweetVimCommands}
Plug 'basyura/bitly.vim',               {'on': b:TweetVimCommands}
Plug 'tyru/open-browser.vim',           {'on': b:TweetVimCommands}
Plug 'mattn/webapi-vim',                {'on': b:TweetVimCommands}
Plug 'mattn/favstar-vim',               {'on': b:TweetVimCommands}
Plug 'Shougo/unite.vim',                {'on': b:TweetVimCommands}
Plug 'Shougo/unite-outline',            {'on': b:TweetVimCommands}
Plug 'Shougo/vimproc.vim',              {'on': b:TweetVimCommands}
" Plug 'Shougo/vimproc.vim',              {'on': b:TweetVimCommands,
"   \ 'build': {
"   \   'windows' : 'tools\\update-dll-mingw',
"   \   'cygwin'  : 'make -f make_cygwin.mak',
"   \   'mac'     : 'make -f make_mac.mak',
"   \   'linux'   : 'make',
"   \   'unix'    : 'make',
"   \   },
"   \ }
unlet b:TweetVimCommands

" List ends here. Plugins become visible to Vim after this call.
call plug#end() " }}}

" Plugins Config {{{
let s:plug = { 'plugs': get(g:, 'plugs', {}) }
function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction " }}}

if s:plug.is_installed('denite.nvim') " {{{
  nnoremap <silent> <Leader>fm  :<C-u>Denite file_mru<CR>
  nnoremap <silent> <Leader>fr  :<C-u>Denite file_rec<CR>
  nnoremap <silent> <Leader>fl  :<C-u>Denite line<CR>
  nnoremap <silent> <Leader>fb  :<C-u>Denite buffer<CR>
  " Change file_rec command.
  if executable('files')
    call denite#custom#var('file_rec', 'command', ['files'])
  endif
  " Change mappings.
  call denite#custom#map('insert', "\<C-j>", 'move_to_next_line')
  call denite#custom#map('insert', "\<C-k>", 'move_to_prev_line')
  " Define alias
  call denite#custom#alias('source', 'file_rec/git', 'file_rec')
  call denite#custom#var('file_rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])
endif " }}}

if s:plug.is_installed('ctrlp.vim') " {{{
  let s:ctrlpUserCommand = executable('files') ?
        \ 'files -a %s' :
        \ ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_user_command = 'files -a %s'
  let g:ctrlp_use_caching = 0 " no cache
  let g:ctrlp_key_loop = 1    " Support multi-byte character
  let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:1000,results:1000'
  let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
endif " }}}

if s:plug.is_installed('caw.vim') " {{{
  function! InitCaw() abort
    if !&l:modifiable
      silent! nunmap <buffer> gc
      silent! xunmap <buffer> gc
      silent! nunmap <buffer> gcc
      silent! xunmap <buffer> gcc
    else
      nmap <buffer> gc <Plug>(caw:prefix)
      xmap <buffer> gc <Plug>(caw:prefix)
      nmap <buffer> gcc <Plug>(caw:hatpos:toggle)
      xmap <buffer> gcc <Plug>(caw:hatpos:toggle)
    endif
  endfunction
  autocmd MyAutoCmd FileType * call InitCaw()
endif " }}}

if s:plug.is_installed('memolist.vim') " {{{
  let g:memolist_path = '~/Dropbox/memo'

  if s:plug.is_installed('denite.nvim')
    nnoremap <Leader>ml :<C-u>call denite#start([{'name': 'file_rec', 'args': [g:memolist_path]}])<CR>
  else
    if s:plug.is_installed('ctrlp.vim') | let g:memolist_ex_cmd = 'CtrlP' | endif
    nnoremap <Leader>ml :MemoList<CR>
  endif
  nnoremap <Leader>mn :MemoNew<CR>
  nnoremap <Leader>mg :MemoGrep<CR>
endif " }}}

if s:plug.is_installed('unite.vim') " {{{
  let g:unite_enable_auto_select = 0
  let g:unite_enable_start_insert = 1
  let g:unite_enable_ignore_case = 1
  let g:unite_enable_smart_case = 1
endif " }}}

if s:plug.is_installed('vim-fontzoom') " {{{
  nmap + <Plug>(fontzoom-larger)
  nmap _ <Plug>(fontzoom-smaller)
endif "}}}

if s:plug.is_installed('neosnippet.vim') " {{{
  " Plugin key-mappings.
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)

  " SuperTab like snippets behavior.
  "imap <expr><TAB>
  " \ pumvisible() ? "\<C-n>" :
  " \ neosnippet#expandable_or_jumpable() ?
  " \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  " For conceal markers.
  if has('conceal')
    set conceallevel=2 concealcursor=niv
  endif
endif " }}}

if s:plug.is_installed('vim-ft-rst_header') " {{{
  let g:rst_header_chars = '#*=-^~"'
  autocmd MyAutoCmd FileType text setl ft=rst
endif " }}}

if s:plug.is_installed('emmet-vim') " {{{
  let g:user_emmet_settings = {
  \  'variables' : { 'lang' : 'ja' },
  \  'php' : { 'extends' : 'html', 'filters' : 'c', },
  \  'xml' : { 'extends' : 'html', },
  \  'haml': { 'extends' : 'html', },
  \ }
endif " }}}

if s:plug.is_installed('vim-gista') " {{{
  let g:gista#client#default_username = 'kashewnuts'
endif " }}}

if s:plug.is_installed('Align') " {{{
  let g:Align_xstrlen = 3      " for japanese string
  let g:DrChipTopLvlMenu = ''  " remove 'DrChip' menu
endif " }}}

if s:plug.is_installed('SQLUtilities') " {{{
  let g:sqlutil_align_comma = 1
endif " }}}

if s:plug.is_installed('vim-easy-align') " {{{
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
endif " }}}

if s:plug.is_installed('vim-trailing-whitespace') " {{{
  let g:extra_whitespace_ignored_filetypes = ['unite']
endif " }}}

if s:plug.is_installed('previm') " {{{
  let g:previm_disable_vimproc = 1
  let g:previm_show_header = 0
  command! PrevimRefresh :call previm#refresh()
endif " }}}

if s:plug.is_installed('TweetVim') " {{{
  let g:tweetvim_display_time = 1
  let g:tweetvim_async_post = 1
endif " }}}

augroup load_insert_snippet_plugins " {{{
  autocmd!
  autocmd InsertEnter * call plug#load(
\   'context_filetype.vim',
\   'neosnippet.vim',
\   'neosnippet-snippets',
\ )
\ | autocmd! load_insert_snippet_plugins
augroup END " }}}

" vim: tw=78 et sw=2 foldmethod=marker

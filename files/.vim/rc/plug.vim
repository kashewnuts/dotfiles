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
" ShougoWare
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
" thinca Plugins
Plug 'thinca/vim-fontzoom'  " Requirement 'set guifont='
Plug 'thinca/vim-ft-rst_header', {'for': 'rst'}
" Web
Plug 'othree/html5.vim', {'for': ['html', 'css', 'javascript', 'jinja', 'htmljinja']}
Plug 'mattn/emmet-vim', {'for': ['html', 'css', 'ruby', 'php', 'haml', 'xml']}
" Git
Plug 'lambdalisue/vim-gista', {'on': 'Gista'}
Plug 'cohama/agit.vim', {'on': 'Agit'}
" Edit
Plug 'bronson/vim-trailing-whitespace', {'on':  'FixWhitespace'}
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'glidenote/memolist.vim', {'on': ['MemoGrep', 'MemoList', 'MemoNew']}
Plug 'tyru/caw.vim'     " Only type 'gcc' when visual or normal mode
" Formater
let b:AligCommands = ['Align', 'SQLUFormatter']
Plug 'vim-scripts/Align',        {'on': b:AligCommands}
Plug 'vim-scripts/SQLUtilities', {'on': b:AligCommands}
unlet b:AligCommands
" Reference & View
Plug 'kannokanno/previm', {'on': 'PrevimOpen'}
" Plug 'vim-jp/vimdoc-ja', {'on': '<Plug>h'}
Plug 'vim-jp/vimdoc-ja'
" Twitter
let b:TweetVimCommands = ['TweetVimSay', 'TweetVimSearch', 'TweetVimMentions', 'TweetVimCurrentLineSay']
Plug 'basyura/TweetVim',        {'on': b:TweetVimCommands}
Plug 'basyura/twibill.vim',     {'on': b:TweetVimCommands}
Plug 'basyura/bitly.vim',       {'on': b:TweetVimCommands}
Plug 'tyru/open-browser.vim',   {'on': b:TweetVimCommands}
Plug 'mattn/webapi-vim',        {'on': b:TweetVimCommands}
Plug 'mattn/favstar-vim',       {'on': b:TweetVimCommands}
Plug 'Shougo/unite.vim',        {'on': b:TweetVimCommands}
Plug 'Shougo/unite-outline',    {'on': b:TweetVimCommands}
Plug 'Shougo/vimproc.vim',      {'on': b:TweetVimCommands,
  \ 'build': {
  \   'windows' : 'tools\\update-dll-mingw',
  \   'cygwin'  : 'make -f make_cygwin.mak',
  \   'mac'     : 'make -f make_mac.mak',
  \   'linux'   : 'make',
  \   'unix'    : 'make',
  \   },
  \ }
unlet b:TweetVimCommands

" List ends here. Plugins become visible to Vim after this call.
call plug#end() " }}}

" Plugins Config {{{
let s:plug = { "plugs": get(g:, 'plugs', {}) }
function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction " }}}

if s:plug.is_installed('ctrlp.vim') " {{{
  if executable('files')
    let g:ctrlp_user_command = 'files -a %s'
  else
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  endif
  let g:ctrlp_use_caching = 0 " no cache
  let g:ctrlp_key_loop = 1    " Support multi-byte character
  let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:1000,results:1000'
endif " }}}

if s:plug.is_installed('memolist.vim') " {{{
  let g:memolist_path = "~/Dropbox/memo"
  let g:memolist_ex_cmd = 'CtrlP'
  nnoremap <Leader>ml :MemoList<CR>
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
  let g:rst_header_chars = "#*=-^~""
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

" vim: tw=78 et sw=2 foldmethod=marker

" vim-plug

" Skip if requirements are not satisfied {{{
if !(executable('curl') && executable('git'))
  finish
endif " }}}

" Plugins List {{{
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.cache/plugged')

" Declare the list of plugins.
" FuzzyFinder
Plug 'ctrlpvim/ctrlp.vim',          {'on': 'CtrlP'}
" Snippets
Plug 'Shougo/neosnippet-snippets',  {'on': []}
Plug 'Shougo/neosnippet.vim',       {'on': []}
" FileType
Plug 'fatih/vim-go',                {'for': 'go'}
Plug 'thinca/vim-ft-rst_header',    {'for': 'rst'}
Plug 'davidhalter/jedi-vim',        {'for': 'python'}
Plug 'tell-k/vim-autopep8',         {'for': 'python'}
" Formater
Plug 'vim-jp/autofmt'
Plug 'junegunn/vim-easy-align',     {'on': '<Plug>(EasyAlign)'}
Plug 'vim-scripts/SQLUtilities',    {'on': 'SQLUFormatter'}
  \ | Plug 'vim-scripts/Align',     {'on': 'SQLUFormatter'}
" Memo
Plug 'glidenote/memolist.vim',      {'on': ['MemoGrep', 'MemoList', 'MemoNew']}
Plug 'lambdalisue/vim-gista',       {'on': 'Gista', 'tag': 'v2.3.3'}
" Reference & View
Plug 'kannokanno/previm',           {'on': 'PrevimOpen'}
  \ | Plug 'tyru/open-browser.vim', {'on': 'PrevimOpen'}
Plug 'vim-jp/vimdoc-ja'
" Twitter
Plug 'twitvim/twitvim',             {'on': [
  \ 'SearchTwitter', 'ListTwitter', 'PosttoTwitter', 'CPosttoTwitter']}

" List ends here. Plugins become visible to Vim after this call.
call plug#end() " }}}

" Plugins Config {{{
let s:plug = { 'plugs': get(g:, 'plugs', {}) }
function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction " }}}

if s:plug.is_installed('ctrlp.vim') " {{{
  nnoremap <C-p> :<C-u>CtrlP<CR>
  let s:ctrlpUserCommand    =
      \ ['.git', 'cd %s && git ls-files . -co --exclude-standard',
      \  (executable('pt') ? 'pt --follow -g' : 'find %s -type f')
      \ ]
  let g:ctrlp_use_caching   = 0  " no cache
  let g:ctrlp_show_hidden   = 1  " Show dotfiles
  let g:ctrlp_key_loop      = 1  " Support multi-byte character
  let g:ctrlp_match_window  = 'bottom,order:btt,min:1,max:10000,results:100'
  let g:ctrlp_custom_ignore = {
      \ 'dir' : '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
      \ }
endif " }}}

if s:plug.is_installed('jedi-vim') " {{{
  let g:jedi#auto_initialization = 0
  let g:jedi#auto_vim_configuration = 0
  let g:jedi#popup_on_dot = 0
  let g:jedi#popup_select_first = 0
  let g:jedi#show_call_signatures = 0
  autocmd MyAutoCmd FileType python setlocal omnifunc=jedi#completions
endif " }}}

if s:plug.is_installed('vim-autopep8') " {{{
  let g:autopep8_max_line_length=120
endif " }}}

if s:plug.is_installed('memolist.vim') " {{{
  let g:memolist_path = '~/Dropbox/memo'
  let g:memolist_memo_suffix = 'md'
  let g:memolist_template_dir_path = '~/.vim/template/memolist'

  if s:plug.is_installed('ctrlp.vim') | let g:memolist_ex_cmd = 'CtrlP' | endif
  nnoremap <silent> <Leader>ml :MemoList<CR>
  nnoremap <silent> <Leader>mn :MemoNew<CR>
  nnoremap <silent> <Leader>mg :MemoGrep<CR>
endif " }}}

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

if s:plug.is_installed('autofmt') " {{{
  set formatexpr=autofmt#japanese#formatexpr()
  let autofmt_allow_over_tw=1
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

if s:plug.is_installed('previm') " {{{
  let g:previm_disable_vimproc = 1
  let g:previm_show_header = 0
  command! PrevimRefresh :call previm#refresh()
  autocmd MyAutoCmd User previm,open-browser.vim doautocmd Previm FileType
endif " }}}

if s:plug.is_installed('twitvim') " {{{
  " Basic
  let twitvim_browser_cmd = (
  \ has('win32') ? 'C:/Program Files (x86)/Google/Chrome/Application/chrome.exe' :
  \ has('win32unix') ? '/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe' :
  \ '')
  let twitvim_force_ssl = 1
  let twitvim_count = 40
  let twitvim_enable_python3 = 1
  let twitvim_allow_multiline = 1
  let twitvim_timestamp_format = '%c'
  let twitvim_show_header = 0

  " Mapping
  nnoremap <Leader>tp :<C-u>PosttoTwitter<CR>
  nnoremap <Leader>tc :<C-u>CPosttoTwitter<CR>
  nnoremap <Leader>tb :<C-u>BPosttoTwitter<CR>
  nnoremap <Leader>tm :<C-u>MentionsTwitter<CR>
  nnoremap <Leader>tf :<C-u>FriendsTwitter<CR><C-w>j
  nnoremap <Leader>tu :<C-u>UserTwitter<CR><C-w>j
  nnoremap <Leader>tr :<C-u>RepliesTwitter<CR><C-w>j
  nnoremap <Leader>ff :<C-u>NextTwitter<CR>

  " ListTwitter
  command! LTCliming ListTwitter climbing
  command! LTVim ListTwitter vim
  command! LTPython ListTwitter python-su
  command! LTJava ListTwitter Ewigkeit java-ja
  command! LTPyfes ListTwitter takuan_osho pyfes-2010-10
  command! LTPyhackSummer ListTwitter takanory pyhacksummer2013
  command! LTPyhackSnow ListTwitter inoshiro pyhack-snow201301
endif " }}}

augroup load_insert_snippet_plugins " {{{
  autocmd!
  autocmd InsertEnter * call plug#load(
\   'neosnippet.vim',
\   'neosnippet-snippets',
\ )
\ | autocmd! load_insert_snippet_plugins
augroup END " }}}

" vim: tw=78 et sw=2 foldmethod=marker

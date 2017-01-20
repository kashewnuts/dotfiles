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
Plug 'ctrlpvim/ctrlp.vim',              {'on': 'CtrlP'}
if (v:version >= 800 || has('nvim')) && has('python3')
  Plug 'Shougo/denite.nvim' | Plug 'Shougo/neomru.vim'
endif
" Snippets
Plug 'Shougo/neosnippet-snippets',      {'on': []}
Plug 'Shougo/neosnippet.vim',           {'on': []}
" FileType
Plug 'fatih/vim-go',                    {'for': 'go'}
Plug 'thinca/vim-ft-rst_header',        {'for': 'rst'}
" Formater
Plug 'junegunn/vim-easy-align',         {'on': '<Plug>(EasyAlign)'}
Plug 'vim-scripts/SQLUtilities',        {'on': 'SQLUFormatter'}
  \ | Plug 'vim-scripts/Align',         {'on': 'SQLUFormatter'}
" Memo
Plug 'glidenote/memolist.vim',          {'on': ['MemoGrep', 'MemoList', 'MemoNew']}
Plug 'lambdalisue/vim-gista',           {'on': 'Gista', 'tag': 'v2.3.3'}
" Reference & View
Plug 'kannokanno/previm' | Plug 'tyru/open-browser.vim'
Plug 'vim-jp/vimdoc-ja'
" Twitter
Plug 'twitvim/twitvim',                 {'on': [
  \ 'SearchTwitter', 'ListTwitter', 'PosttoTwitter', 'CPosttoTwitter']}

" List ends here. Plugins become visible to Vim after this call.
call plug#end() " }}}

" Plugins Config {{{
let s:plug = { 'plugs': get(g:, 'plugs', {}) }
function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction " }}}

if s:plug.is_installed('denite.nvim') " {{{
  " NOTE: In the case of vim-plug, calling from another plug-in will be slower,
  " so denite.nvim will not lazy-load.
  nnoremap <silent> <Leader>fm  :<C-u>Denite file_mru<CR>
  nnoremap <silent> <Leader>fr  :<C-u>Denite file_rec<CR>
  nnoremap <silent> <Leader>fg  :<C-u>Denite file_rec/git<CR>
  nnoremap <silent> <Leader>fl  :<C-u>Denite line<CR>
  nnoremap <silent> <Leader>fb  :<C-u>Denite buffer<CR>

  " Change file_rec command.
  if executable('pt')
    call denite#custom#var('file_rec', 'command', ['pt', '--follow', '-g:', ''])
    call denite#custom#var('grep', 'command', ['pt'])
    call denite#custom#var('grep', 'default_opts', [])
    call denite#custom#var('grep', 'recursive_opts', [])
  endif
  " Define alias
  call denite#custom#alias('source', 'file_rec/git', 'file_rec')
  call denite#custom#var('file_rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])
endif " }}}

if s:plug.is_installed('ctrlp.vim') " {{{
  nnoremap <C-p> :<C-u>CtrlP<CR>
  let s:ctrlpUserCommand    = executable('pt') ?
        \ 'pt --follow -g:' :
        \ ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_use_caching   = 0  " no cache
  let g:ctrlp_key_loop      = 1  " Support multi-byte character
  let g:ctrlp_match_window  = 'bottom,order:btt,min:1'
  let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
endif " }}}

if s:plug.is_installed('memolist.vim') " {{{
  let g:memolist_path = '~/Dropbox/memo'
  let g:memolist_memo_suffix = 'md'
  let g:memolist_template_dir_path = '~/.vim/template/memolist'

  if s:plug.is_installed('denite.nvim')
    nnoremap <silent> <Leader>ml :
      \ <C-u>call denite#start([{'name': 'file_rec', 'args': [g:memolist_path]}])<CR>
  else
    if s:plug.is_installed('ctrlp.vim') | let g:memolist_ex_cmd = 'CtrlP' | endif
    nnoremap <silent> <Leader>ml :MemoList<CR>
  endif
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
  " NOTE: In the case of vim-plug, startup will fail, so leave as not lazy-load.
  let g:previm_disable_vimproc = 1
  let g:previm_show_header = 0
  " let g:previm_custom_css_path = '~/.vim/template/previm/github-markdown.css'
  command! PrevimRefresh :call previm#refresh()
endif " }}}

if s:plug.is_installed('twitvim') " {{{
  " Basic
  let twitvim_browser_cmd =
    \ 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
  let twitvim_force_ssl = 1
  let twitvim_count = 40
  let twitvim_enable_python3 = 1
  let twitvim_allow_multiline = 1
  let twitvim_timestamp_format = '%c'
  " Filter
  let twitvim_filter_enable = 1
  let twitvim_filter_regex = '!\v^【(自動|定期).*|(.*https?://ask\.fm.*)|#(countkun|1topi|bookmeter)|(.*(#|#)[^\s]+){5,}|#RTした人全員|.*分以内に.*RTされたら|^!(RT)|^[^RT].*RT|RT\s.*RT\s|^!(BOT)|^[^BOT].*BOT|BOT\s.*BOT\s'

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

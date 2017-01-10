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
Plug 'ctrlpvim/ctrlp.vim',              {'on': 'CtrlP'}
if (v:version >= 800 || has('nvim')) && has('python3')
  Plug 'Shougo/denite.nvim' | Plug 'Shougo/neomru.vim'
endif
" Snippets
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
" Edit
Plug 'bronson/vim-trailing-whitespace', {'on':  'FixWhitespace'}
Plug 'fatih/vim-go',                    {'for': 'go'}
Plug 'glidenote/memolist.vim',          {'on': ['MemoGrep', 'MemoList', 'MemoNew']}
" Formater
Plug 'junegunn/vim-easy-align',         {'on': '<Plug>(EasyAlign)'}
let b:AlignCommands = ['Align', 'SQLUFormatter']
Plug 'vim-scripts/Align',               {'on': b:AlignCommands}
Plug 'vim-scripts/SQLUtilities',        {'on': b:AlignCommands}
unlet b:AlignCommands
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
  nnoremap <silent> <Leader>fm  :<C-u>Denite file_mru<CR>
  nnoremap <silent> <Leader>fr  :<C-u>Denite file_rec<CR>
  nnoremap <silent> <Leader>fl  :<C-u>Denite line<CR>
  nnoremap <silent> <Leader>fb  :<C-u>Denite buffer<CR>
  " Change file_rec command.
  if executable('files')
    call denite#custom#var('file_rec', 'command', ['files'])
  endif
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
  let g:ctrlp_match_window = 'bottom,order:ttb,min:1'
  let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
endif " }}}

if s:plug.is_installed('memolist.vim') " {{{
  let g:memolist_path = '~/Dropbox/memo'
  let g:memolist_memo_suffix = 'txt'
  let g:memolist_template_dir_path = '~/.vim/template/memolist'

  if s:plug.is_installed('denite.nvim')
    nnoremap <Leader>ml :<C-u>call denite#start([{'name': 'file_rec', 'args': [g:memolist_path]}])<CR>
  else
    if s:plug.is_installed('ctrlp.vim') | let g:memolist_ex_cmd = 'CtrlP' | endif
    nnoremap <Leader>ml :MemoList<CR>
  endif
  nnoremap <Leader>mn :MemoNew<CR>
  nnoremap <Leader>mg :MemoGrep<CR>
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
  " let g:previm_custom_css_path = '~/.vim/template/previm/github-markdown.css'
  command! PrevimRefresh :call previm#refresh()
endif " }}}

if s:plug.is_installed('twitvim') " {{{
  " Basic
  let twitvim_browser_cmd = 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
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
  nnoremap <Leader>tn :<C-u>NextTwitter<CR>

  " ListTwitter
  command! ListCliming ListTwitter climbing
  command! ListVim ListTwitter vim
  command! ListPython ListTwitter python-su
  command! ListJava ListTwitter Ewigkeit java-ja
  command! ListPyfes ListTwitter takuan_osho pyfes-2010-10
  command! ListPyhackSummer ListTwitter takanory pyhacksummer2013
  command! ListPyhackSnow ListTwitter inoshiro pyhack-snow201301
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

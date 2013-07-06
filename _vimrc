"--------------------------------------------------
"NeoBundle 設定
"--------------------------------------------------
set nocompatible                      " Be iMproved

if has('vim_starting')
    set runtimepath+=~/dotfiles/vimfiles/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle'))
" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
" pathogen互換機能
NeoBundleLocal ~/.vim/bundle_manual

"--------------------------------------------------
"github にあるプラグイン
"--------------------------------------------------
" 非同期通信を可能にする
" 'build'が指定されているのでインストール時に自動的に
" 指定されたコマンドが実行され vimproc がコンパイルされる
NeoBundle "Shougo/vimproc", {
            \ "build": {
            \   "windows"   : "make -f make_mingw32.mak",
            \   "cygwin"    : "make -f make_cygwin.mak",
            \   "mac"       : "make -f make_mac.mak",
            \   "unix"      : "make -f make_unix.mak",
            \ }}
NeoBundleLazy "Shougo/neocomplcache.vim", {
            \ "autoload": {
            \   "insert": 1,
            \ }}
NeoBundleLazy "Shougo/neosnippet.vim", {
            \ "depends": ["honza/vim-snippets"],
            \ "autoload": {
            \   "insert": 1,
            \ }
            \}
NeoBundleLazy 'Shougo/unite.vim', {
            \   'autoload' : {
            \       'commands' : [ 'Unite' ]
            \   }
            \}
NeoBundleLazy 'Shougo/vimfiler', {
            \   'autoload' : {
            \       'commands' : [ "VimFiler" ]
            \   }
            \}
NeoBundleLazy 'Shougo/vimshell', {
            \   'autoload' : {
            \       'commands' : [ "VimShell" ]
            \   }
            \}
NeoBundleLazy "thinca/vim-quickrun", {
            \ "autoload": {
            \       'commands' : [ "Quickrun" ]
            \ }}
NeoBundleLazy 'thinca/vim-scouter', {
            \   'autoload' : {
            \       'commands' : [ "Scouter" ]
            \   }
            \}
NeoBundleLazy 'mjbrownie/vim-htmldjango_omnicomplete', {
            \   "autoload" : { "filetypes" : ["python", "python3", "djangohtml"] }
            \}
NeoBundleLazy 'jmcantrell/vim-virtualenv', {
            \   "autoload" : { "filetypes" : ["python", "python3", "djangohtml",
            \                                 "jinja", "htmljinja"]
            \                }
            \}
NeoBundle 'kashewnuts/vim-ft-rst_header'    " respect thinca/vim-ft-rst_header
NeoBundle 'akira-hamada/friendly-grep.vim'

filetype plugin indent on             " Required!
NeoBundleCheck                        " Installation check.

"--------------------------------------------------
" common
"--------------------------------------------------
" autocmdのリセット
autocmd!
syntax on "シンタックスハイライトを有効にする
set encoding=utf8 "デフォルトの文字コード
set ambiwidth=double "文脈依存の文字幅を正常に表示する
set expandtab "タブをスペースに展開する(noexpandtab:展開しない)
set number " 行番号を非表示 (nonumber:非表示)
set tabstop=4 " タブの画面上での幅
set softtabstop=4 "ファイル内の  が対応する空白の数
set shiftwidth=4 "シフト移動幅
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
set smartindent "新しい行を作ったときに高度な自動インデントを行う
set showmatch "閉じ括弧が入力されたとき、対応する括弧を表示する
set imdisable "挿入モードから抜ける際、入る際にIMEがオフになる
set list listchars=tab:>-,trail:_ " タブと行末の空白文字を可視化
set nowritebackup
" OSのクリップボードを使用する
set clipboard+=unnamed
set clipboard+=autoselect

" バックアップファイルを生成しない
set noswapfile
set nobackup
autocmd BufWritePre * :%s/\s\+$//ge " 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\t/  /ge " 保存時にtabをスペースに変換する

" 新しく作った行の最初の文字が '#' のとき、インデントを解除しない
autocmd FileType python :inoremap # X#
autocmd FileType python :set textwidth=80 "桁数の制限
autocmd FileType rst :set textwidth=90 "桁数の制限(100だと文字が小さい)

"ウィンドウ分割時にウィンドウサイズを調節する設定です。Shiftキー＋矢印キー。
nnoremap <silent> <S-Left>  :5wincmd <<CR>
nnoremap <silent> <S-Right> :5wincmd ><CR>
nnoremap <silent> <S-Up>    :5wincmd -<CR>
nnoremap <silent> <S-Down>  :5wincmd +<CR>

"検索結果に移動したとき、その位置を画面の中央にする。
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=LightBlue guibg=DarkBlue
match ZenkakuSpace /　/

"--------------------------------------------------
" pair close checker.
" from othree vimrc ( http://github.com/othree/rc/blob/master/osx/.vimrc )
"--------------------------------------------------
function! s:ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

"--------------------------------------------------
" IndentGuides 設定
"--------------------------------------------------
let s:bundle = neobundle#get("vim-indent-guides")
function! s:bundle.hooks.on_source(bundle)
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_auto_colors = 0
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#121212 ctermbg=233
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#262626 ctermbg=235
endfunction
unlet s:bundle

"--------------------------------------------------
" jedi 設定
"--------------------------------------------------
let s:bundle = neobundle#get("jedi-vim")
function! s:bundle.hooks.on_source(bundle)
    let g:jedi#auto_initialization = 1
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#rename_command = "<leader>R"
    let g:jedi#popup_on_dot = 1
    let g:jedi#show_function_definition = 0
    autocmd FileType python let b:did_ftplugin = 1
endfunction
unlet s:bundle

"--------------------------------------------------
" vim-htmldjango_omnicomplete 設定
"--------------------------------------------------
let s:bundle = neobundle#get("vim-htmldjango_omnicomplete")
function! s:bundle.hooks.on_source(bundle)
    autocmd FileType htmldjango set omnifunc=htmldjangocomplete#CompleteDjango
    autocmd FileType htmldjango inoremap {% {% %}<left><left><left>
    autocmd FileType htmldjango inoremap {{ {{ }}<left><left><left>
endfunction
unlet s:bundle

"--------------------------------------------------
" quickrun 設定
"--------------------------------------------------
nmap <Leader>r <Plug>(quickrun)
let s:bundle = neobundle#get("vim-quickrun")
function! s:bundle.hooks.on_source(bundle)
    let g:quickrun_config={'*': {'split': ''}} " 横分割をするようにする
    " 横分割時は下へ､ 縦分割時は右へ新しいウィンドウが開くようにする
    set splitbelow
    set splitright
endfunction
unlet s:bundle

"--------------------------------------------------
" neocomplcache 設定
"--------------------------------------------------
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
let s:bundle = neobundle#get("neocomplcache.vim")
function! s:bundle.hooks.on_source(bundle)
    "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use smartcase.
    let g:neocomplcache_enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplcache_min_syntax_length = 3
    let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

    " Enable heavy features.
    " Use camel case completion.
    let g:neocomplcache_enable_camel_case_completion = 1
    " Use underbar completion.
    let g:neocomplcache_enable_underbar_completion = 1

    " Define dictionary.
    let g:neocomplcache_dictionary_filetype_lists = {
                \ 'default' : '',
                \ 'vimshell' : $HOME.'/.vimshell_hist',
                \ 'scheme' : $HOME.'/.gosh_completions'
                \ }

    " Define keyword.
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplcache#undo_completion()
    inoremap <expr><C-l>     neocomplcache#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return neocomplcache#smart_close_popup() . "\<CR>"
        " For no inserting <CR> key.
        "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplcache#close_popup()
    inoremap <expr><C-e>  neocomplcache#cancel_popup()
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

    " For cursor moving in insert mode(Not recommended)
    "inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
    "inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
    "inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
    "inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
    " Or set this.
    "let g:neocomplcache_enable_cursor_hold_i = 1
    " Or set this.
    "let g:neocomplcache_enable_insert_char_pre = 1

    " AutoComplPop like behavior.
    "let g:neocomplcache_enable_auto_select = 1

    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplcache_enable_auto_select = 1
    "let g:neocomplcache_disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplcache_omni_patterns')
        let g:neocomplcache_omni_patterns = {}
    endif
    let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endfunction
unlet s:bundle

"--------------------------------------------------
" neosnippet 設定
"--------------------------------------------------
let s:bundle = neobundle#get("neosnippet.vim")
function! s:bundle.hooks.on_source(bundle)
    " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)"
                \: pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)"
                \: "\<TAB>"

    " For snippet_complete marker.
    if has('conceal')
        set conceallevel=2 concealcursor=i
    endif

    " Enable snipMate compatibility feature.
    let g:neosnippet#enable_snipmate_compatibility = 1

    " Tell Neosnippet about the other snippets
    let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
endfunction
unlet s:bundle

"--------------------------------------------------
" VimFiler 設定
"--------------------------------------------------
let s:bundle = neobundle#get("vimfiler")
function! s:bundle.hooks.on_source(bundle)
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_safe_mode_by_default = 0
endfunction
unlet s:bundle

"--------------------------------------------------
" friendly-grep.vim 設定
"--------------------------------------------------
let s:bundle = neobundle#get("friendly-grep.vim")
function! s:bundle.hooks.on_source(bundle)
    nnoremap <C-g> <ESC>:FriendlyGrep<CR>

    " 一つ前の結果へジャンプ
    nnoremap <LEFT> :cprevious<CR>
    " 次の結果へジャンプ
    nnoremap <RIGHT> :cnext<CR>
    " 最初の結果へジャンプ
    nnoremap <UP> :<C-u>cfirst<CR>
    " 最後の結果へジャンプ
    nnoremap <DOWN> :<C-u>clast<CR>

    let g:friendlygrep_target_dir = '/Users/KashunYoshida/'
    " よく検索するディレクトリあるいはファイル名を登録出来ます。
    " 上記だと '/Users/KashunYoshida' が検索対象入力時に毎回入力済みになる。
    " (デフォルトは空)

    let g:friendlygrep_recursively = 1
    " 毎回「再帰検索する?」と聞かれるのがウザい場合は
    " これを設定すると聞いてこなくなります。
    " 1 : 常に再帰検索
    " 0 : 常に非再帰検索
    " (デフォルトはnull、毎回聞いてきます)

    let g:friendlygrep_display_result_in = 'tab'
    " 検索結果の開き方を指定出来ます。
    " 'tab' : 新規タブに表示
    " 'split' : 現在のウィンドウを横分割して上に表示 (デフォルト)
    " 'vsplit' : 現在のウィンドウを縦分割して左に表示
    " 'quickfix' : 現在のウィンドウにquickfixリストと共に表示
endfunction
unlet s:bundle

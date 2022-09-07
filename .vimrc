" Vundles
syntax on
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/

call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'preservim/tagbar'
Plugin 'danro/rename.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'preservim/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'Yggdroot/indentLine'
"Plugin 'pseewald/vim-anyfold.git'
Plugin 'dracula/vim', { 'name': 'dracula' }

Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'

"" common lisp
Plugin 'kien/rainbow_parentheses.vim'
"Plugin 'kovisoft/slimv'

Plugin 'neoclide/coc.nvim'

Plugin 'vim-scripts/tinymode.vim'
Plugin 'vim-scripts/vim-tags'
"Plugin 'mattn/calendar-vim'
"Plugin 'vim-syntastic/syntastic'
"Plugin 'ycm-core/YouCompleteMe'
"Plugin 'python-mode/python-mode'
"Plugin 'mhinz/vim-startify'
Plugin 'petobens/poet-v'
Plugin 'ludovicchabant/vim-gutentags.git'

" Godot
Plugin 'habamax/vim-godot'

" Editing
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'SirVer/ultisnips'
Plugin 'tpope/vim-surround'


" Colorschemes
Plugin 'morhetz/gruvbox.git'
Plugin 'veloce/vim-aldmeris'
Plugin 'tribela/vim-transparent'

call vundle#end()

" General settings
filetype plugin indent on
set nocompatible
set number
set ruler
set mouse=a
set hidden
set backspace=indent,eol,start
set pastetoggle=<Leader><f2>
"set textwidth=72
inoremap kj <ESC>
set list listchars=tab:▸\ ,trail:-
"set autochdir
set laststatus=2
set noshowmode
set cc=80


set wrap
set linebreak

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
"set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
"set guifont=DinaRemaster\ Regular\ 12
set guifont=ProggySquareTT\ 12
"set guifont=Terminus\ 12

"nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

" No autocomments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


" Spellcheck
"set spell spellang=en_us

" Better jump
nnoremap ' `
nnoremap ` '

" Space to toggle folds
"autocmd Filetype python set foldmethod=indent

nnoremap <Space> za
nnoremap <C-Space> zA
"vnoremap <Space> zf

"nnoremap <leader>zO zR
"nnoremap <leader>zC zM

" Search options
set ignorecase
set smartcase
set incsearch
set hls " Highlight search

" Tabs
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Custom commands
command! WriteAsRoot :execute ':silent w !sudo tee % > /dev/null' | :edit!

" Keep quiet
set visualbell
set noerrorbells
set shortmess=atI

" No Match Paren
let loaded_matchparen = 1

" Wildmenu
set wildmenu
set wildmode=list:longest,full

" Up and down linebreaks
nnoremap j gj
nnoremap k gk

" Emacs-like bindings
"inoremap <C-a> <ESC>0i
"inoremap <C-e> <ESC>A
"inoremap <C-d> <DELETE>
"inoremap <C-b> <LEFT>
"inoremap <C-f> <RIGHT>

" Follow file, or open new file if it doesn't exist
"map gf :e <cfile><cr>

" plasticboy Markdown
"au BufNewFile,BufRead *.md setlocal filetype=markdown
"let g:vim_markdown_initial_foldlevel=2

" Use ctrl-[hjkl] to select the active split
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Set local current directory to same directory as current buffer
nnoremap ;cd :lcd %:p:h<CR>:pwd<CR>

" Colorscheme
"set t_Co=256
"colorscheme xoria256
"colorscheme jellybeans
let g:aldmeris_transparent = 1
"colorscheme aldmeris
set background=dark
colorscheme gruvbox

" Leader bindings
let mapleader = ';'
let maplocalleader = '\'
"map <leader>s :set list!<CR>

" PLUGINS
" anyfold
"autocmd Filetype * AnyFoldActivate
set foldlevel=99 " Open all folds"

" pymode

let g:pymode_trim_whitespaces = 1
let pymode_options = 1
let g:pymode_preview_height = &previewheight
autocmd Filetype python nnoremap <buffer> <leader>pl :PymodeLint<CR>
autocmd Filetype python nnoremap <buffer> <leader>pa :PymodeLintAuto<CR>
let g:pymode_lint_on_rite = 0
let pymode_rope = 0
let g:pymode_rope_refix = '<leader>pr'
"let g:pymode_indent = 1
"let g:pymode_folding = 1
"let g:pymode_motion = 1
let g:pymode_lint_cwindow = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_goto_definition_bind = '<leader>rg'
let g:pymode_rope_rename_bind = '<leader>rr'
let g:pymode_rope_autoimport_bind = '<leader>ri'
let g:pymode_virtualenv = 0

" poetv
"let g:poetv_auto_activate = 1

" Buffergator
map <Leader>b :BuffergatorOpen<CR>
map <Leader>B :BuffergatorClose<CR>
"map <Leader>a :BuffergatorTabsToggle<CR>
let g:buffergator_suppress_keymaps = 1
"let g:buffergator_autodismiss_on_select = 1

" NERDTree
let NERDTreeAutoDeleteBuffer = 1
map <Leader>f :NERDTreeFocus<CR>
map <Leader>F :NERDTreeClose<CR>

let g:NERDTreeQuitOnOpen = 3
map <Leader>R :WriteAsRoot<CR>

" Buffer management
map <Leader>h :b#<CR>
map <Leader>l :buffers<CR>
map <Leader>k :bprev<CR>
"map <Leader><Leader> :e #<CR>
map <Leader>j :bnext<CR>
"map <Leader>g :buffer 

" ctrlp
let g:ctrlp_map = '<Leader>o'
let  g:ctrlp_cmd = 'CtrlPMixed'
map <Leader>oo :CtrlPMixed<CR>
"map <Leader>oo :CtrlPMRUFiles<CR>
map <Leader>of :CtrlP<CR>
map <Leader>ob :CtrlPBuffer<CR>
map <Leader>ot :CtrlPTag<CR>
"map <Leader>oT :CtrlPBufTagAll<CR>
let g:ctrlp_by_filename = 1
let g:ctrlp_max_depth = 5
let g:ctrlp_max_files = 1000
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = "~/tmp/ctrlp"
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_working_path_mode = ''
"let g:ctrlp_custom_ignore = {
    "\ 'dir':  '.gitignore|.git|.cache|__pycache__|.pytest_cache',
    "\ 'file': '\.swp|\.mp3$|\.png$\|\.jpg$\|\.mkv$\|\.avi$|\.pdf$|\.torrent$|\.pyc$',
    "\ 'link': '',
    "\ }

let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/]\.(git|hg|svn)$',
\ 'file': '\v\.(exe|so|dll|pyc)$',
\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
\ }


"" tinymode : Easy window resize
call tinymode#EnterMap("winsize", "<C-W>h", "h")
call tinymode#EnterMap("winsize", "<C-W>k", "k")
call tinymode#EnterMap("winsize", "<C-W>j", "j")
call tinymode#EnterMap("winsize", "<C-W>l", "l")
call tinymode#Map("winsize", "k", "wincmd -")
call tinymode#Map("winsize", "j", "wincmd +")
call tinymode#Map("winsize", "h", "wincmd <")
call tinymode#Map("winsize", "l", "wincmd >")
call tinymode#ModeMsg("winsize", "Resize window [h,j,k,l]")
map <C-W>e :wincmd =<CR>
map <C-W>m :wincmd _<CR>

" Slimv
"let g:slimv_swank_cmd = '! tmux neww "ccl64 -l /usr/share/emacs/site-lisp/slime/start-swank.lisp " '
"let g:slimv_swank_cmd = '! tmux neww "authbind ecl -l /usr/share/emacs/site-lisp/slime/start-swank.lisp " '
"let g:slimv_swank_cmd = '! tmux neww "ccl64 -l /usr/share/emacs/site-lisp/slime/start-swank.lisp " '
"let g:slimv_swank_cmd = '! tmux neww "athbind sbcl --load /usr/share/emacs/site-lisp/slime/start-swank.lisp " '
"let g:slimv_swank_cmd = '! tmux neww "sbcl --load C:/cygwin64/home/gerry/opt/slime/start-swank.lisp " '

let g:slimv_swank_cmd = '! mintty -e sbcl --load C:/cygwin64/home/gerry/opt/slime/start-swank.lisp &'

"let g:slimv_swank_cmd = '! mintty -e "/cygdrive/c/Program Files (x86)/clisp-2.49/clisp.exe" -repl -i "C:/cygwin64/home/Gerry/.clisprc.lisp" C:/cygwin64/home/gerry/opt/slime/start-swank.lisp &'
"let g:slimv_swank_cmd = '! mintty -e "c:/ccl/wx86cl64.exe" -l C:/cygwin64/home/gerry/opt/slime/start-swank.lisp &'

"let g:slimv_updatetime = 200
"let g:slimv_lisp = '/usr/bin/sbcl'
"let g:slimv_imp = 'sbcl'
let g:slimv_repl_split = 4
"let g:slimv_browser_cmd = 'dwb'
"let g:slimv_ctags = '/usr/bin/ctags'
let g:slimv_clhs_root = 'file:///usr/share/doc/HyperSpec/Body/'
"let g:paredit_leader = ';s'
let g:paredit_mode = 0
"let g:slimv_leader = ';s'
"let g:slimv_keybindings = 3
"let g:paredit_leader = ','
let g:slimv_leader = ','
let g:lisp_rainbow = 0
"let g:paredit_electric_return=0
"let g:paredit_mode = 0

" tags
set tags=./tags;/,tags;/

"" Rainbow Parens
let g:rbpt_colorpairs = [
    \ ['yellow',   'RoyalBlue3'],
    \ ['blue',     'green'],
    \ ['brown', 'DarkOrchid3'],
    \ ['red',    'firebrick3'],
    \ ['magenta',   'RoyalBlue3'],
    \ ['yellow',       'RoyalBlue3'],
    \ ['darkgreen',    'SeaGreen3'],
    \ ['cyan',         'firebrick3'],
    \ ]
let g:rbpt_max = 8
au VimEnter * RainbowParenthesesActivate
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"map <Leader>gr :RainbowParenthesesToggle<CR>

"" vimwiki
"map <Leader>wha :VimwikiAll2HTML<CR>
"map <Leader>wls :VimwikiSplitLink<CR>
"let g:vimwiki_folding = 1
"let g:vimwiki_use_calendar = 1
"let wiki_1 = {'path': '~/Nextcloud/vimwiki/',
             "\'syntax': 'markdown',
             "\'ext': '.md'}
""let wiki_1.html_template = '~/public_html/template.tpl'
"let wiki_1.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}

"let g:vimwiki_list = [wiki_1]

" vimwiki stuff "
" Run multiple wikis "

"let g:vimwiki_list = [
                        "\{'path': '~/Documents/vimwiki/personal.wiki'},
                        "\{'auto_diary_indes': 1}
                "\]
"au BufRead,BufNewFile *.wiki set filetype=vimwiki
":autocmd FileType vimwiki map d :VimwikiMakeDiaryNote
"function! ToggleCalendar()
  "execute ":Calendar"
  "if exists("g:calendar_open")
    "if g:calendar_open == 1
      "execute "q"
      "unlet g:calendar_open
    "else
      "g:calendar_open = 1
    "end
  "else
    "let g:calendar_open = 1
  "end
"endfunction
":autocmd FileType vimwiki map c :call ToggleCalendar()

" taglist
"map <Leader>t :TlistToggle<CR>
let Tlist_Exit_OnlyWindow = 1
let Tlist_Show_One_File = 0
let Tlist_Enable_Fold_Column = 1

"" tagbar
map <Leader>t :TagbarOpen fj<CR>
map <Leader>T :TagbarClose<CR>

"" vimnotes
"let g:notes_directory = '/home/gerry/seafile/plain/vim-notes/'
"let g:notes_title_sync = 'rename_file'
"let g:notes_suffix = '.md'
"map <leader>n/ :SearchNotes 
"map <leader>ne :NoteFromSelectedText<cr>
"map <leader>ns :SplitNoteFromSelectedText<cr>
"map <leader>nt :TabNoteFromSelectedText<cr>

"" Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0

"let g:syntastic_mode_map = { "mode": "passive" }

"nmap <leader>ss :SyntasticCheck<cr>
"nmap <leader>sr :SyntasticReset<cr>
"nmap <leader>sc :lclose<cr>

" DelimitMate
let delimitMate_quotes = "\" ' `"
""""""""""""""""""""
" GnuPG Extensions "
""""""""""""""""""""

" Tell the GnuPG plugin to armor new files.
let g:GPGPreferArmor=1

" Tell the GnuPG plugin to sign new files.
let g:GPGPreferSign=1

augroup GnuPGExtra
" Set extra file options.
    autocmd BufReadCmd,FileReadCmd *.\(gpg\|asc\|pgp\) call SetGPGOptions()
" Automatically close unmodified files after inactivity.
    autocmd CursorHold *.\(gpg\|asc\|pgp\) quit
augroup END

function SetGPGOptions()
" Set updatetime to 1 minute.
    set updatetime=60000
" Fold at markers.
    set foldmethod=marker
" Automatically close all folds.
    set foldclose=all
" Only open folds with insert commands.
    set foldopen=insert
endfunction

" Yank WORD to system clipboard in normal mode
nmap <leader>y "+yE
" Yank selection to system clipboard in visual mode
vmap <leader>y "+y
" Paste from clipboard
nmap <leader>p "+p
nmap <leader>P "+P

" Numbertoggle
":set number relativenumber


"" YouCompleteMe ycm
"let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
"let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
"let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
"let g:ycm_complete_in_comments = 1 " Completion in comments
"let g:ycm_complete_in_strings = 1 " Completion in string
"let g:ycm_disable_signature_help = 0

"let g:ycm_autoclose_preview_window_after_insertion = 1
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

set splitbelow


" coc

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
"inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"                              "\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
      let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

"" END coc

" Indent
"imap <C-j> <CR><ESC>O<TAB>
inoremap <silent> <C-j> <CR><ESC>O
" Vim color
let g:indentLine_color_term = 242

" GVim
let g:indentLine_color_gui = '#A4E57E'


" Easymotion
map <LEADER><LEADER> <Plug>(easymotion-prefix)

" paste mode
set pastetoggle=<F2>

" Indent guide
map <Leader>i :IndentLinesToggle<CR>

" airline
if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.colnr = ' ㏇:'
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = ' ␊:'
let g:airline_symbols.linenr = ' ␤:'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
"let g:airline_symbols.colnr = ' :'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty='⚡'


let g:airline_exclude_preview = 0
let g:airline_inactive_collapse=1
let g:airline_inactive_alt_sep=1

let g:airline_theme='gruvbox'

let g:airline#extensions#poetv#enabled=1
let g:airline#extensions#branch#enabled=1


"" Show full path of filename
"function! FilenameForLightline()
    "return expand('%:~:.')
"endfunction

"vim-session
let g:session_autosave = 'no'
let g:session_autoload = 'no'

" calendar
let g:calendar_date_full_month_name=1
let g:calendar_cache_directory = "/home/gerry/Nextcloud/Notes/calendar.vim/"

"" vim-flake8
"let g:flake8_show_in_gutter = 1
"autocmd FileType python map <buffer> <leader>sf :call flake8#Flake8()<CR>

autocmd Filetype python nnoremap <buffer> <F5> :w<CR>:!clear; python "%"<CR>
autocmd Filetype python nnoremap <buffer> <F6> :w<CR>:vert ter python "%"<CR>
"autocmd Filetype python nnoremap <buffer> <F6> :w<CR>:vert ter python3 "%"<CR>

" Godot
if !has_key( g:, 'ycm_language_server' )
  let g:ycm_language_server = []
endif

let g:ycm_language_server += [
  \   {
  \     'name': 'godot',
  \     'filetypes': [ 'gdscript' ],
  \     'project_root_files': [ 'project.godot' ],
  \     'port': 6008
  \   }
  \ ]

func! GodotSettings() abort
    setlocal expandtab
    setlocal foldmethod=expr
    setlocal tabstop=4
    nnoremap <buffer> <F4> :GodotRunLast<CR>
    nnoremap <buffer> <F5> :GodotRun<CR>
    nnoremap <buffer> <F6> :GodotRunCurrent<CR>
    nnoremap <buffer> <F7> :GodotRunFZF<CR>
endfunc
augroup godot | au!
    au FileType gdscript call GodotSettings()
augroup end

" nodejs prettier
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" UltiSnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<C-k>"
"let g:UltiSnipsJumpBackwardTrigger="<C-i>"
let g:UltiSnipsListSnippets="<C-h>" "List possible snippets based on current file
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" transparent
nnoremap <Leader>r :TransparentToggle<CR>

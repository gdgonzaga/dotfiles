" Vundles
syntax on
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

"Plugin 'vim-scripts/vimwiki'
"Plugin 'vim-scripts/taglist.vim'
Plugin 'jeetsukumaran/vim-buffergator'
"Plugin 'fholgado/minibufexpl.vim'
Plugin 'vim-scripts/bufkill.vim'
"Plugin 'danro/rename.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-vinegar.git'
"Plugin 'scrooloose/nerdtree'
"Plugin 'tpope/vim-fugitive'
"Plugin 'ervandew/supertab'

" common lisp
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'kovisoft/slimv'

Plugin 'vim-scripts/tinymode.vim'
"Plugin 'mattn/calendar-vim'
Plugin 'jamessan/vim-gnupg'
"Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'

" Editing
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Lokaltog/vim-easymotion'

"" UltiSnips
"Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'

"" Javascript
"Plugin 'othree/javascript-libraries-syntax.vim'
"Plugin 'jelera/vim-javascript-syntax'
"Plugin 'pangloss/vim-javascript'
"Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'marijnh/tern_for_vim'

"" Angular
"Plugin 'matthewsimo/angular-vim-snippets'
"Plugin 'claco/jasmine.vim'

"" Node
"Plugin 'myhere/vim-nodejs-complete'

"" Colorschemes
"Plugin 'tomasr/molokai'
"Plugin 'vim-scripts/xoria256.vim'
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
"inoremap <C-k> <ESC>
inoremap kj <ESC>
set list listchars=tab:▸\ ,trail:-
"set autochdir

set wrap
set linebreak

nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" No autocomments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Spellcheck
"set spell spellang=en_us

" Better jump
nnoremap ' `
nnoremap ` '

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

" Wildmenu
set wildmenu
set wildmode=list:longest,full

" Up and down linebreaks
nnoremap j gj
nnoremap k gk

" Follow file, or open new file if it doesn't exist
"map gf :e <cfile><cr>

" Mutt
au BufRead /tmp/mutt-* set tw=72

" plasticboy Markdown
au BufNewFile,BufRead *.md setlocal filetype=markdown
let g:vim_markdown_initial_foldlevel=2

" Use ctrl-[hjkl] to select the active split
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Set local current directory to same directory as current buffer
nnoremap ;cd :lcd %:p:h<CR>:pwd<CR>

" Colorscheme
set t_Co=256
colorscheme xoria256.gdg
"colorscheme jellybeans

" Leader bindings
let mapleader = ';'
let maplocalleader = '\'
"map <leader>s :set list!<CR>

" Buffergator
map <Leader>b :BuffergatorToggle<CR>
"map <Leader>a :BuffergatorTabsToggle<CR>
let g:buffergator_suppress_keymaps = 1
"let g:buffergator_autodismiss_on_select = 1

" NERDTree
let NERDTreeAutoDeleteBuffer = 1
map <Leader>f :NERDTreeToggle<CR>
"map <Leader>F :NERDTreeClose<CR>
map <Leader>R :WriteAsRoot<CR>

" Buffer management
map <Leader><Leader> :b#<CR>
map <Leader>k :bprev<CR>
map <Leader>j :bnext<CR>
map <Leader>g :buffer 

" ctrlp
let g:ctrlp_map = '<Leader>o'
let  g:ctrlp_cmd = 'CtrlPMixed'
map <Leader>oo :CtrlPMixed<CR>
map <Leader>or :CtrlPMRUFiles<CR>
map <Leader>of :CtrlPFiles<CR>
map <Leader>ob :CtrlPBuffer<CR>
map <Leader>ot :CtrlPBufTag<CR>
"map <Leader>oT :CtrlPBufTagAll<CR>
let g:ctrlp_by_filename = 1
let g:ctrlp_max_depth = 40
let g:ctrlp_max_files = 0
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = "~/tmp/ctrlp"
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '.gitignore|.git|.cache',
    \ 'file': '\.swp|\.mp3$|\.png$\|\.jpg$\|\.mkv$\|\.avi$',
    \ 'link': '',
    \ }


" tinymode : Easy window resize
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

" NERDTree
"autocmd VimEnter * if !argc() | NERDTree | endif

" Slimv
"let g:slimv_swank_cmd = '! tmux neww "ccl64 -l /usr/share/emacs/site-lisp/slime/start-swank.lisp " '
"let g:slimv_swank_cmd = '! tmux neww "authbind ecl -l /usr/share/emacs/site-lisp/slime/start-swank.lisp " '
"let g:slimv_swank_cmd = '! tmux neww "ccl64 -l /usr/share/emacs/site-lisp/slime/start-swank.lisp " '
"let g:slimv_swank_cmd = '! tmux neww "athbind sbcl --load /usr/share/emacs/site-lisp/slime/start-swank.lisp " '
let g:slimv_swank_cmd = '! tmux neww "sbcl --load /home/gerry/opt/slime/start-swank.lisp " '

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

" vimwiki
map <Leader>wha :VimwikiAll2HTML<CR>
map <Leader>wls :VimwikiSplitLink<CR>
let g:vimwiki_folding = 1
let g:vimwiki_use_calendar = 1
let wiki_1 = {}
let wiki_1.syntax = 'media'
let wiki_1.ext = '.wiki'
let wiki_1.path = '~/seafile/plain/vimwiki/'
"let wiki_1.html_template = '~/public_html/template.tpl'
"let wiki_1.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
"let wiki_1.index = 'main'

let lin_wiki = {}
let lin_wiki.syntax = 'markdown'
let lin_wiki.ext = '.md'
let lin_wiki.path = '~/seafile/plain/linwiki/'
"let lin_wiki.path_html = '~/mnt/public-vimwiki-html/'

"let g:vimwiki_list = [wiki_1, public_wiki]
let g:vimwiki_list = [wiki_1, lin_wiki]

" taglist
"map <Leader>t :TlistToggle<CR>
"let Tlist_Exit_OnlyWindow = 1
"let Tlist_Show_One_File = 0
"let Tlist_Enable_Fold_Column = 1

" tagbar
map <Leader>t :TagbarToggle<CR>

"" vimnotes
"let g:notes_directory = '/home/gerry/seafile/plain/vim-notes/'
"let g:notes_title_sync = 'rename_file'
"let g:notes_suffix = '.md'
"map <leader>n/ :SearchNotes 
"map <leader>ne :NoteFromSelectedText<cr>
"map <leader>ns :SplitNoteFromSelectedText<cr>
"map <leader>nt :TabNoteFromSelectedText<cr>

"" Syntastic
set statusline+=%{SyntasticStatuslineFlag()}
let g:syntastic_check_on_open=1

" DelimitMate
let delimitMate_quotes = "\" ` " 
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

" UltiSnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-f>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" YouCompleteMe ycm
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

" Indent
imap <C-j> <CR><Esc>O

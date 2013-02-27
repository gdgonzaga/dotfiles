" Vundles
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'vim-scripts/vimwiki'
"Bundle 'Lokaltog/vim-easymotion'
"Bundle 'sandeepcr529/Buffet.vim'
Bundle 'vim-scripts/taglist.vim'
Bundle 'jeetsukumaran/vim-buffergator'
"Bundle 'vim-scripts/minibufexpl.vim'
Bundle 'vim-scripts/bufkill.vim'
"Bundle 'xolox/vim-notes'
Bundle 'danro/rename.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
"Bundle 'tpope/vim-markdown'
"Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'ervandew/supertab'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'vim-scripts/slimv.vim'
Bundle 'vim-scripts/tinymode.vim'
Bundle 'mattn/calendar-vim'
"Bundle 'vim-scripts/bufexplorer.zip'
"Bundle 'vim-scripts/YankRing.vim'

" General settings
filetype plugin indent on
syntax on
set nocompatible
set number
set ruler
set mouse=a
set hidden
set backspace=indent,eol,start
set pastetoggle=<Leader><f2>
"set textwidth=72
"inoremap <C-k> <ESC>
inoremap jj <ESC>
set list listchars=tab:▸\ ,trail:-
set autochdir

set wrap
set linebreak

nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" No autocomments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

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
set shiftwidth=2
set softtabstop=2
set tabstop=2

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
nnoremap gj nnoremap k gk

" Follow file, or open new file if it doesn't exist
"map gf :e <cfile><cr>

" Mutt
au BufRead /tmp/mutt-* set tw=72

" Use ctrl-[hjkl] to select the active split
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>


" Colorscheme
set t_Co=256
colorscheme xoria256

" Leader bindings
let mapleader = ';'
let maplocalleader = '\'
"map <leader>s :set list!<CR>

" Buffergator
let g:buffergator_suppress_keymaps = 1
map <Leader>b :BuffergatorToggle<CR>
map <Leader>a :BuffergatorTabsToggle<CR>

" NERDTree
let NERDTreeAutoDeleteBuffer=1
map <Leader>f :NERDTree<CR>
map <Leader>F :NERDTreeClose<CR>
"map <Leader>t :TagbarToggle<CR>
map <Leader>R :WriteAsRoot<CR>

" Buffer management
map <Leader><Leader> :b#<CR>
map <Leader>j :bprev<CR>
map <Leader>k :bnext<CR>
map <Leader>g :buffer 

" ctrlp
let g:ctrlp_map = '<Leader>of'
map <Leader>of :CtrlPMixed<CR>
map <Leader>or :CtrlPMRUFiles<CR>
map <Leader>ob :CtrlPBuffer<CR>
map <Leader>ot :CtrlPBufTag<CR>
map <Leader>oT :CtrlPBufTagAll<CR>
let g:ctrlp_max_depth = 10
let g:ctrlp_max_files = 0

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

" CtrlP
let g:ctrlp_custom_ignore = {
    \ 'dir':  '.gitignore|.git|.cache',
    \ 'file': '\.swp|\.mp3$|\.png$\|\.jpg$\|\.mkv$\|\.avi$',
    \ 'link': '',
    \ }

" Slimv
"let g:slimv_swank_cmd = '! tmux neww "ccl64 -l /usr/share/emacs/site-lisp/slime/start-swank.lisp " '
"let g:slimv_swank_cmd = '! tmux neww "authbind ecl -l /usr/share/emacs/site-lisp/slime/start-swank.lisp " '
let g:slimv_swank_cmd = '! tmux neww "authbind ccl64 -l /usr/share/emacs/site-lisp/slime/start-swank.lisp " '
"let g:slimv_swank_cmd = '! tmux neww "athbind sbcl --load /usr/share/emacs/site-lisp/slime/start-swank.lisp " '

let g:slimv_updatetime = 200
let g:slimv_lisp = '/usr/bin/sbcl'
let g:slimv_imp = 'sbcl'
let g:slimv_browser_cmd = 'vp.sh'
let g:slimv_ctags = '/usr/bin/ctags'
let g:slimv_clhs_root = 'file:///usr/share/doc/HyperSpec/Body/'
let g:paredit_leader = ';s'
let g:slimv_leader = ';s'
"let g:slimv_keybindings = 3
let g:lisp_rainbow = 0
let g:paredit_electric_return=0
"let g:paredit_mode = 0

" vim-slime
let g:slime_target= "tmux"
let g:slime_paste_file = tempname()

" Rainbow Parens
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
au Syntax lisp RainbowParenthesesToggle
"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces
"map <Leader>gr :RainbowParenthesesToggle<CR>

" vimwiki
map <Leader>wha :VimwikiAll2HTML<CR>
map <Leader>wls :VimwikiSplitLink<CR>
let g:vimwiki_folding = 1

let wiki_1 = {}
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'
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
map <Leader>t :TlistToggle<CR>
let Tlist_Exit_OnlyWindow = 1
let Tlist_Show_One_File = 0
let Tlist_Enable_Fold_Column = 1

"" vimnotes
"let g:notes_directory = '/home/gerry/seafile/plain/vim-notes/'
"let g:notes_title_sync = 'rename_file'
"let g:notes_suffix = '.md'
"map <leader>n/ :SearchNotes 
"map <leader>ne :NoteFromSelectedText<cr>
"map <leader>ns :SplitNoteFromSelectedText<cr>
"map <leader>nt :TabNoteFromSelectedText<cr>

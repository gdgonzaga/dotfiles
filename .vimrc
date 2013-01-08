" Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Vundles
""Bundle 'vim-scripts/vimwiki'
Bundle 'xolox/vim-notes'
Bundle 'danro/rename.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'ervandew/supertab'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'majutsushi/tagbar'
Bundle 'vim-scripts/slimv.vim'
Bundle 'vim-scripts/tinymode.vim'
Bundle 'vim-scripts/bufexplorer.zip'
Bundle 'vim-scripts/YankRing.vim'

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
set textwidth=72
inoremap <C-k> <ESC>
set list listchars=tab:▸\ ,trail:-

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
map <leader>s :set list!<CR>
map <Leader>f :NERDTree<CR>
map <Leader>F :NERDTreeClose<CR>
map <Leader>t :TagbarToggle<CR>
map <Leader>R :WriteAsRoot<CR>

" Buffer management
map <Leader><Leader> :b#<CR>
map <Leader>j :bprev<CR>
map <Leader>k :bnext<CR>

" bufexplorer
map <Leader>b :BufExplorer<CR>

" ctrlp
let g:ctrlp_map = '<Leader>o<Space>'
map <Leader>o<Space> :CtrlPMixed<CR>
map <Leader>of :CtrlPMRUFiles<CR>
map <Leader>ob :CtrlPBuffer<CR>
map <Leader>ot :CtrlPBufTag<CR>
map <Leader>oT :CtrlPBufTagAll<CR>

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
    \ 'dir':  '.git|.cache',
    \ 'file': '\.png$\|\.jpg$\|\.mkv$\|\.avi$',
    \ 'link': '',
    \ }

" Slimv
"let g:slimv_swank_cmd = '! xterm -e sbcl --load /usr/share/emacs/site-lisp/slime/start-swank.lisp & '
let g:slimv_updatetime = 10000
let g:slimv_lisp = '/usr/bin/sbcl'
let g:slimv_imp = 'sbcl'
let g:slimv_browser_cmd = 'vp.sh'
let g:slimv_ctags = '/usr/bin/ctags'
let g:slimv_clhs_root = 'file:///usr/share/doc/HyperSpec/Body/'
let g:paredit_leader = ','
let g:slimv_leader = ';s'
let g:lisp_rainbow = 1

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
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" vimwiki
let g:vimwiki_list = [{'path': '~/Documents/vimwiki' }]


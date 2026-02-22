" Leader key
let mapleader = "\<Space>"

" Leader mappings
noremap <Leader>b ^
noremap <Leader>e :e .<CR>
noremap <Leader>r <C-R>
noremap <Leader>j <C-W><C-J>
noremap <Leader>k <C-W><C-K>
noremap <Leader>h <C-W><C-H>
noremap <Leader>l <C-W><C-L>
noremap <Leader>u i_<ESC>r
noremap <Leader>n :vs<CR>
noremap <Leader>q :q<CR>
noremap <Leader>o <C-O>
noremap <Leader>i <C-I>
noremap <Leader>a ggVG
noremap <Leader>/ 0i//<ESC>
noremap <Leader>s :source ~/.vimrc<CR>
noremap <Leader>w :w<CR>
noremap <Leader>t :tabnew<CR>

" Function keys
noremap <F1> <ESC>:tabprev<CR>
vnoremap <F1> <ESC>:tabprev<CR>
inoremap <F1> <ESC>
noremap <F2> :w<CR>
inoremap <F2> <ESC>:w<CR>
noremap <F12> :set relativenumber!<CR>
set pastetoggle=<F11>

" Tab jumps to matching bracket
noremap <TAB> %

" " CP compilation keys (commented out)
" " Python run
" noremap <F6> <ESC>:w<CR>:!python3 %<CR>
" inoremap <F6> <ESC>:w<CR>:!python3 %<CR>

" " GCC with optimizations (fast compilation)
" noremap <F7> <ESC>:w<CR>:execute 'cd %:p:h'<CR>:!g++ -std=c++17 -DONPC -O2 -o "%<" "%" && "./%<" < inp<CR>
" inoremap <F7> <ESC>:w<CR>:execute 'cd %:p:h'<CR>:!g++ -std=c++17 -DONPC -O2 -o "%<" "%" && "./%<" < inp<CR>

" " Clang with sanitizer for debugging
" noremap <F8> <ESC>:w<CR>:execute 'cd %:p:h'<CR>:!clang++ -fsanitize=address -std=c++17 -Wall -Wextra -Wshadow -DONPC -O2 -o "%<" "%" && "./%<" < inp<CR>
" inoremap <F8> <ESC>:w<CR>:execute 'cd %:p:h'<CR>:!clang++ -fsanitize=address -std=c++17 -Wall -Wextra -Wshadow -DONPC -O2 -o "%<" "%" && "./%<" < inp<CR>

" " GCC with warnings, no input (manual testing)
" noremap <F9> <ESC>:w<CR>:execute 'cd %:p:h'<CR>:!g++ -std=c++17 -Wall -Wextra -Wshadow -DONPC -O2 -o "%<" "%" && "./%<" <CR>
" inoremap <F9> <ESC>:w<CR>:execute 'cd %:p:h'<CR>:!g++ -std=c++17 -Wall -Wextra -Wshadow -DONPC -O2 -o "%<" "%" && "./%<" <CR>

" " GCC with sanitizer and input
" " noremap <F10> <ESC>:w<CR>:!g++ -fsanitize=address -std=c++17 -Wall -Wextra -Wshadow -DONPC -O2 -o %< % && ./%< < inp<CR>
" " inoremap <F10> <ESC>:w<CR>:!g++ -fsanitize=address -std=c++17 -Wall -Wextra -Wshadow -DONPC -O2 -o %< % && ./%< < inp<CR>

" " GCC with warnings and input
" noremap <F10> <ESC>:w<CR>:execute 'cd %:p:h'<CR>:!g++ -std=c++17 -Wall -Wextra -Wshadow -DONPC -O2 -o "%<" "%" && "./%<" < inp<CR>
" inoremap <F10> <ESC>:w<CR>:execute 'cd %:p:h'<CR>:!g++ -std=c++17 -Wall -Wextra -Wshadow -DONPC -O2 -o "%<" "%" && "./%<" < inp<CR>" Plugins

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'      " Comment with gc
Plug 'tpope/vim-surround'        " Change brackets/quotes
Plug 'jiangmiao/auto-pairs'      " Auto-close brackets
Plug 'catppuccin/vim'            " Catppuccin theme
call plug#end()

" Theme
set termguicolors
set background=dark
colorscheme catppuccin_mocha

" Display
set number relativenumber
set cursorline
set showcmd
set scrolloff=5

" Search
set hlsearch incsearch ignorecase smartcase

" Editing
set clipboard=unnamed
set mouse=a
set noerrorbells
set noswapfile
set autoread
set hidden
set history=1000
set vb t_vb=
set mousehide

" Indentation
set autoindent smartindent
set expandtab tabstop=4 shiftwidth=4 softtabstop=4
set backspace=indent,eol,start
set cin
set si
set smarttab

" Text rendering
set is

" Undo
set undofile
set undodir=~/.vim/undo
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" File handling
filetype plugin indent on
syntax on

" File explorer
let g:netrw_keepdir = 0
let g:netrw_localrmdir='rm -r'
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" Commands
command! Rld source ~/.vimrc

" Auto commands
autocmd FileType cpp setlocal makeprg=g\+\+\ %\ \-g\ \-std\=c\+\+17\ \-Wall
autocmd FileType haskell setlocal makeprg=ghci\ %
autocmd FileType python setlocal makeprg=python3\ %
autocmd FileType sh setlocal makeprg=%

autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePost .vimrc source $MYVIMRC

" Miscellaneous
set shellslash
set iskeyword+=:
let c_syntax_for_h=""

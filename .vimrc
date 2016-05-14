" pressing <TAB> in command mode lets you see what your other options are
set wildmenu

" behave similarly to a shell, i.e. complete only up to the point of ambiguity (while still showing you what your options are)
set wildmode=list:longest,full

" will make /-style searches case-sensitive only if there is a capital letter in the search expression
" *-style searches continue to be consistently case-sensitive.
set ignorecase
set smartcase

" set the terminal title
set title

" maintain more context around the cursor
set scrolloff=3

" enable full line numbering
set nu

" Intuitive backspacing in insert mode
set backspace=indent,eol,start
" File-type highlighting and configuration.
" Run :filetype (without args) to see what you may have
" to turn on yourself, or just set them all to be sure.

syntax on
filetype on
filetype plugin on
"filetype indent on

" highlight search terms...
set hlsearch

set incsearch " dynamically as they are typed.

" suppress beeping
set visualbell

" tab = 4 spaces
set tabstop=4
set smarttab

"set ai " auto indent
"set si " smart indet
"colorscheme evening
" set autoindent

set showmatch " show maching braces

" With a map leader (\ - default) it's possible to do extra key combinations
" like <leader>w saves the current file
"let mapleader = ","
"let g:mapleader = ","

" fast saving and exit
nmap <leader>w :w!<cr>
nmap <leader>x :x!<cr>
nmap <leader>q :q!<cr>

set encoding=utf8

" don't wrap long lines
set nowrap

" have the mouse enabled all the time
set mouse=a

" highlight current line
set cursorline
"set cursorcolumn
hi CursorLine   cterm=NONE ctermbg=grey ctermfg=black guibg=grey guifg=black
hi CursorColumn cterm=NONE ctermbg=grey ctermfg=black guibg=grey guifg=black
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" highlight words under cursor
autocmd CursorMoved * silent! exe printf('match Search /\<%s\>/', expand('<cword>'))

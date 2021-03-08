set nocompatible

filetype plugin indent on

set autoindent
set noexpandtab
set softtabstop =8
set shiftwidth  =8

set hidden
set laststatus =2

set incsearch
set hlsearch
set wrapscan

set ttyfast
set lazyredraw

set shell=/bin/bash

set backup
set backupdir   =$HOME/.vim/files/backup/
set backupext   =-vimbackup
set backupskip  =
set directory   =$HOME/.vim/files/swap//
set updatecount =100
set undofile
set undodir     =$HOME/.vim/files/undo/
set viminfo     ='100,n$HOME/.vim/files/info/viminfo

set mouse=a
let mapleader="\<Space>""
nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>p :bprevious<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeQuitOnOpen = 1
nnoremap <F2> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fzf_action = {
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit'
    \ }
nnoremap <c-p> :FZF<cr>
nnoremap <c-b> :Buffers<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colorscheme & lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set background=dark
if (has('termguicolors'))
  set termguicolors
endif

syntax on
autocmd vimenter * colorscheme material

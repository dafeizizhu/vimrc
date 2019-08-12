set number
filetype indent on
set autoread
set hlsearch
syntax enable
set encoding=utf8
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set lbr 
set tw=500
set ai
set si
set wrap
set nobackup
set backupcopy=yes

" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" vim-vue
Plugin 'posva/vim-vue'

" ale
Plugin 'w0rp/ale'

" nerdtree
Plugin 'scrooloose/nerdtree'

" ctrlp
Plugin 'ctrlpvim/ctrlp.vim'

call vundle#end()            " required
filetype plugin indent on    " required

let g:ale_linters = {
\ 'javascript': ['standard'],
\}

let g:ctrlp_custom_ignore = '\v[\/](node_modules|\.(git|hg|svn)$)'

autocmd FileType vue syntax sync fromstart

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

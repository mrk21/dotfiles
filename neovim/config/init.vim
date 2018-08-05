"### Base ###
set number
set ruler
set nocompatible
set clipboard+=unnamedplus

" search
set incsearch
set hlsearch
set showmatch

" white characters
set list
set listchars=eol:$,tab:>\ ,extends:<

" indent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

" Disable cusor key.
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>

inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" Keep indent of blank line.
" nnoremap o oX<C-h>
" nnoremap O OX<C-h>
" inoremap <CR> <CR>X<C-h>

" Transition a command mode without entering a shift key.
nnoremap ; :

" Tab move
nnoremap <C-l> gt
nnoremap <C-h> gT

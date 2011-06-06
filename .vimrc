version 6.0
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
imap <D-BS> 
imap <M-BS> 
imap <M-Down> }
inoremap <D-Down> <C-End>
imap <M-Up> {
inoremap <D-Up> <C-Home>
noremap! <M-Right> <C-Right>
noremap! <D-Right> <End>
noremap! <M-Left> <C-Left>
noremap! <D-Left> <Home>
map! <D-v> *
nmap gx <Plug>NetrwBrowseX
map <M-Down> }
noremap <D-Down> <C-End>
map <M-Up> {
noremap <D-Up> <C-Home>
noremap <M-Right> <C-Right>
noremap <D-Right> <End>
noremap <M-Left> <C-Left>
noremap <D-Left> <Home>
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
vmap <BS> "-d
vmap <D-x> "*d
vmap <D-c> "*y
vmap <D-v> "-d"*P
nmap <D-v> "*P
let &cpo=s:cpo_save
unlet s:cpo_save
set backspace=indent,eol,start
set fileencodings=ucs-bom,utf-8,default,latin1
set guitablabel=%M%t
set helplang=en
set langmenu=none
set mouse=a
set printexpr=system('open\ -a\ Preview\ '.v:fname_in)\ +\ v:shell_error
set termencoding=utf-8

set tabstop=4
set shiftwidth=4
syntax on
set autoindent
set smartindent
set ch=2
let c_comment_strings=1
set showmatch
set guioptions-=T
set incsearch
set rnu

" set up python syntax
au FileType python setl autoindent tabstop=4 expandtab shiftwidth=4 softtabstop=4

"enable mix
au BufRead,BufNewFile *.mix setfiletype mix
au BufRead,BufNewFile *.mixal setfiletype mix

filetype plugin indent on
set hlsearch
set nocompatible
set sh=/bin/zsh
inoremap jj <Esc>
"colorscheme wombat
colorscheme ir_black

set laststatus=2
set background=dark
set autoindent
set history=150
set noexpandtab
set visualbell
nnoremap / /\v
vnoremap / /\v
set gdefault
set colorcolumn=78
nnoremap ; :
set ignorecase
inoremap jj <Esc>
set hidden

" makes <Leader> = ,
let mapleader = "\<Space>"
" makes <Leader>l show me a list of all buffers
nnoremap <Leader>l :buffers<CR>:buffer<Space>
" makes <Leader>g go to the previous buffer
nnoremap <Leader>g :e #<CR>
" makes <Leader>1 go to buffer 1
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>
" yank command will go to clipboard
nnoremap <Leader>y "*y

" set relativenumber when I open a buffer
autocmd BufRead * set relativenumber


" vim: set ft=vim :

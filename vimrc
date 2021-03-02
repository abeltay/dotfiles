set nocompatible              " be iMproved, required

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'

" fzf setup
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Go
Plug 'fatih/vim-go', { 'tag': 'v1.24', 'for': ['go', 'gomod'] }

" React, ES6
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'jsx'] }

" GraphQL
Plug 'jparise/vim-graphql', { 'tag': 'v1.3', 'for': 'graphql' }

" Commands - PlugInstall, PlugUpdate, PlugClean[!], PlugUpgrade (Upgrade vim-plug)
call plug#end()

" Basic settings
let mapleader      = ','
let maplocalleader = ','

set encoding=utf-8
set showcmd                     " display incomplete commands
set re=0

" Showing numbers on the left side of the screen
set relativenumber              " add relative numbering

" Searching
set incsearch                   " incremental searching
set hlsearch                    " highlight matches
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" Turn off search highlight
nnoremap <leader>/ :nohlsearch<CR>

" Set working directory to current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" FZF settings
nnoremap <silent> <leader>f :Files<CR>

" Set jj as esc
imap jj <Esc>

" Whitespace
set nowrap                      " don't wrap lines
set backspace=indent,eol,start  " backspace through everything in insert mode

au BufNewFile,BufRead {Gemfile,Rakefile,config.ru} set ft=ruby
au BufNewFile,BufRead {go.mod} set ft=gomod
au BufNewFile,BufRead Jenkinsfile setf groovy

au Filetype gitcommit setl spell tw=72 colorcolumn=+1
au Filetype groovy,html,javascript,json,ruby,scss setl sw=2 ts=2 et
au Filetype markdown setl spell wrap lbr nolist sw=2 ts=2 et

" Highlighting
hi SpellBad ctermfg=white ctermbg=red cterm=none
hi MatchParen ctermfg=magenta ctermbg=none cterm=none

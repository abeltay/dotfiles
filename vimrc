set nocompatible              " be iMproved, required

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'

" fzf setup
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Go
Plug 'fatih/vim-go', { 'tag': '*' }

" React, ES6
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'jsx'] }
Plug 'mxw/vim-jsx', { 'for': 'jsx' }

" Commands - PlugInstall, PlugUpdate, PlugClean[!], PlugUpgrade (Upgrade vim-plug)
call plug#end()

" Basic settings
let mapleader      = ' '
let maplocalleader = ' '

set encoding=utf-8
set showcmd                     " display incomplete commands

" Searching
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" Showing numbers on the left side of the screen
set relativenumber              " add relative numbering

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" FZF settings
nnoremap <silent> <Leader><Leader> :Files<CR>

" vim-go settings
let g:go_fmt_command = "goimports"
let g:go_metalinter_command='golangci-lint'

" Change esc to jj
imap jj <Esc>

" Whitespace
set nowrap                      " don't wrap lines
set backspace=indent,eol,start  " backspace through everything in insert mode

au BufNewFile,BufRead *.{md,markdown,mdown,mkd,mkdn,txt} set ft=markdown
au BufNewFile,BufRead {Gemfile,Rakefile,config.ru} set ft=ruby
au BufNewFile,BufRead *.scss set ft=scss.css
au BufNewFile,BufRead *.slim set ft=slim
au BufNewFile,BufRead Jenkinsfile setf groovy

au Filetype gitcommit setl spell tw=72 colorcolumn=+1
au Filetype groovy,html,javascript,json,ruby,scss.css,slim setl sw=2 ts=2 et
au Filetype markdown setl spell wrap lbr nolist sw=2 ts=2 et
au FileType python setl sw=4 ts=4 et

" Highlighting
hi SpellBad ctermfg=white ctermbg=red cterm=none
hi MatchParen ctermfg=magenta ctermbg=none cterm=none

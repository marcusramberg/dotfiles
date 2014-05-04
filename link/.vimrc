set nocompatible

" Pathogen
call pathogen#infect()
call pathogen#helptags()
 
set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
filetype off
 
syntax on
set number
set mouse=a
set mousehide

set hlsearch
set showmatch
set incsearch
set ignorecase
set autoindent
set history=1000
set cursorline
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set clipboard=unnamed
set directory=/tmp

let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang'

let g:tagbar_left = 1
let g:tagbar_sort = 0
let g:tagbar_autoshowtag = 1
let g:tagbar_autoclose = 1
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_width = 30 
let g:tagbar_foldlevel = 2
let g:vim_markdown_folding_disabled=1
let g:SuperTabDefaultCompletionType = "context"


autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType go compiler go
autocmd FileType go autocmd BufWritePre <buffer> Fmt

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
endif 


:nmap <silent> <leader>a :Ag
:nmap <silent> <leader>d <Plug>DashGlobalSearch
:nmap <silent> <leader>p :TagbarToggle<cr>


colorscheme Tomorrow-Night-Bright

call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails.git'
Bundle 'spllr/vim-padrino'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-sensible'
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle 'garbas/vim-snipmate'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rake'
Bundle 'Rip-Rip/clang_complete'
Bundle 'scrooloose/syntastic'
Bundle 'yko/mojo.vim'
Bundle 'majutsushi/tagbar'
Bundle 'vim-perl/vim-perl'
Bundle 'rdunklau/vim-perltidy'
Bundle 'ngmy/vim-rubocop'
Bundle 'rking/ag.vim'
Bundle 'jnwhiteh/vim-golang'
Bundle 'plasticboy/vim-markdown'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'vim-scripts/fakeclip'
Bundle 'othree/html5.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'godlygeek/tabular'
Bundle 'tomtom/vimtlib'
Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline'
Bundle 'ervandew/supertab'
Bundle 'chriskempson/vim-tomorrow-theme'

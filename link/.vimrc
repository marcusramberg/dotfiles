set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'kien/ctrlp.vim'
Plugin 'JazzCore/ctrlp-cmatcher'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails.git'
Plugin 'spllr/vim-padrino'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'rizzatti/funcoo.vim'
Plugin 'rizzatti/dash.vim'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-rake'
if has('osx')
  Plugin 'Rip-Rip/clang_complete' 
  Plugin 'eraserhd/vim-ios' 
endif
Plugin 'scrooloose/syntastic'
Plugin 'yko/mojo.vim' 
Plugin 'majutsushi/tagbar'
Plugin 'vim-perl/vim-perl'
Plugin 'rdunklau/vim-perltidy'
Plugin 'ngmy/vim-rubocop'
Plugin 'rking/ag.vim'
Plugin 'jnwhiteh/vim-golang'
Plugin 'plasticboy/vim-markdown'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'godlygeek/tabular'
Plugin 'tomtom/vimtlib'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'edkolev/tmuxline.vim'
Plugin 'ervandew/supertab'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'csexton/jekyll.vim'
Plugin 'wting/rust.vim'
Plugin 'tonchis/vim-to-github'

set t_Co=256
colorscheme Tomorrow-Night-Bright
 
filetype on
 
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

set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)


" Obj-c Autocomplete
let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/'
let g:clang_complete_auto=1

" Airline
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fons = 1
let g:airline_theme = 'tomorrow'

let g:tagbar_left = 1
let g:tagbar_sort = 0
let g:tagbar_autoshowtag = 1
let g:tagbar_autoclose = 1
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_width = 30 
let g:tagbar_foldlevel = 2
let g:vim_markdown_folding_disabled=1
let g:SuperTabDefaultCompletionType = "context"
let g:jekyll_path = "~/Source/blog"
let g:syntastic_javascript_checkers = ['jsxhint']


autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType go compiler go
autocmd FileType go autocmd BufWritePre <buffer> Fmt
au BufRead,BufNewFile *.md,*.markdown setlocal textwidth=79 wrap linebreak nolist




if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
endif 


:nmap <silent> <leader>a :Ag
:nmap <silent> <leader>d <Plug>DashGlobalSearch
:nmap <silent> <leader>p :TagbarToggle<cr>
:nmap <silent> <leader>o :CtrlPMRU<cr>


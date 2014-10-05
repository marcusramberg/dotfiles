set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'JazzCore/ctrlp-cmatcher'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails.git'
Bundle 'spllr/vim-padrino'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-sensible'
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'chase/vim-ansible-yaml'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rake'
Bundle 'scrooloose/syntastic'
Bundle 'yko/mojo.vim' 
Bundle 'majutsushi/tagbar'
Bundle 'vim-perl/vim-perl'
Bundle 'rdunklau/vim-perltidy'
Bundle 'ngmy/vim-rubocop'
Bundle 'rking/ag.vim'
Bundle 'fatih/vim-go'
Bundle 'godlygeek/tabular'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'othree/html5.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'tomtom/vimtlib'
Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline'
Bundle 'edkolev/tmuxline.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'csexton/jekyll.vim'
Bundle 'wting/rust.vim'
Bundle 'tonchis/vim-to-github'
Bundle 'hsanson/vim-android'
Bundle 'whatyouhide/vim-gotham'
Bundle 'vim-pandoc/vim-pandoc'
Bundle 'vim-pandoc/vim-pandoc-syntax' 

set t_Co=256
colorscheme Tomorrow-Night-Bright
 
filetype plugin indent on
 
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
set pastetoggle=<leader>v

set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)

" Airline
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gotham'

let g:tagbar_left = 1
let g:tagbar_sort = 0
let g:tagbar_autoshowtag = 1
let g:tagbar_autoclose = 1
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_width = 30 
let g:tagbar_foldlevel = 2
let g:vim_markdown_folding_disabled=1
let g:jekyll_path = "~/Source/blog"
let g:syntastic_javascript_checkers = ['jsxhint']
let g:pandoc#modules#disabled = ["folding"]


autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd BufNewFile,BufReadPost *.go set filetype=go
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
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-g>u\<Tab>"

colorscheme gotham

if $TERM_PROGRAM =~ "iTerm"
  if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
endif
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

let g:UltiSnipsExpandTrigger ="<Leader><Tab>"
let g:UltiSnipsJumpForwardTrigger="<Leader><Tab>"
let g:UltiSnipsJumpBackwardTrigger="<Leader><s-Tab>"

" Tab navigation
nnoremap tn :tabnew<CR>
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
map <space> viw


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
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-rake'
Plugin 'scrooloose/syntastic'
Plugin 'yko/mojo.vim' 
Plugin 'majutsushi/tagbar'
Plugin 'vim-perl/vim-perl'
Plugin 'rdunklau/vim-perltidy'
Plugin 'ngmy/vim-rubocop'
Plugin 'rking/ag.vim'
Plugin 'fatih/vim-go'
Plugin 'godlygeek/tabular'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'tomtom/vimtlib'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'edkolev/tmuxline.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'csexton/jekyll.vim'
Plugin 'wting/rust.vim'
Plugin 'tonchis/vim-to-github'
Plugin 'hsanson/vim-android'

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

set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)

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
let g:jekyll_path = "~/Source/blog"
let g:syntastic_javascript_checkers = ['jsxhint']


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

colorscheme Tomorrow-Night-Bright

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
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

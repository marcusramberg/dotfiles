require 'user.plugins'
require 'user.settings'
require 'user.globals'
require 'user.keybindings'
require 'user.lsp-config'

vim.cmd('colorscheme dracula')
vim.cmd('filetype plugin indent on')

-- augroup autoSaveAndRead
--     autocmd!
--     autocmd TextChanged,InsertLeave,FocusLost * silent! wall
--     autocmd CursorHold * silent! checktime
-- augroup END

-- Autobalance after window resize
-- autocmd VimResized * wincmd =
-- autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
-- autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
-- autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
-- autocmd BufNewFile,BufReadPost *.go set filetype=go
-- autocmd FileType go compiler go
-- autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
-- autocmd BufNewFile,BufRead *.tt setf tt2
-- autocmd BufEnter,TabEnter,WinEnter * syn match ErrorMsg /[^\x00-\x7F]/
-- autocmd BufEnter,TabEnter,WinEnter * syn match ErrorMsg /\s\+$/
-- au BufRead,BufNewFile *.md,*.markdown setlocal tw=79 fo+=tv



-- command! Fuck w !sudo tee % >/dev/null

-- let g:ansible_extra_syntaxes = "sh.vim perl.vim"

-- :autocmd BufRead,BufNewFile /Users/marcus/Source/DNB/* call SetDnbOptions()
-- :autocmd BufRead,BufNewFile /Users/marcus/Source/DNB/infra-templates/* call SetDnbInfraOptions()

-- function! SetDnbOptions()
--   setlocal tabstop=4 shiftwidth=4
-- endfunction

-- function! SetDnbInfraOptions()
--   let g:ale_linter_aliases = {'yaml': ['cloudformation', 'yaml']}
-- endfunction

-- "define :Tidy command to run perltidy on visual selection || entire buffer"
-- command! -range=% -nargs=* Tidy <line1>,<line2>!LC_CTYPE=C LANG=C perltidy

-- "run :Tidy on entire buffer and return cursor to (approximate) original position"
-- function! DoTidy()
--     let l = line(".")
--     let c = col(".")
--     :Tidy
--     call cursor(l, c)
-- endfun

-- "shortcut for normal mode to run on entire buffer then return to current line"
-- au Filetype perl nmap <Leader>t :call DoTidy()<CR>

-- "shortcut for visual mode to run on the the current visual selection"
-- au Filetype perl vmap <Leader>t :Tidy<CR>


-- filetype plugin indent on
-- autocmd FileType yaml setl indentkeys-=<:>

-- " Fix parens match to look correctly.
-- hi! MatchParen cterm=NONE,bold gui=NONE,bold  guibg=#5e5855 guifg=NONE

-- " Perl syntax settings

-- auto BufEnter * :set title


require 'user.settings'
require 'user.plugins'
require 'user.cmp'
require 'user.globals'
require 'user.keybindings'
require 'user.autocmd'
require 'user.lsp-config'

vim.cmd('colorscheme dracula')

vim.api.nvim_command('command! Fuck w !sudo tee % >/dev/null')

vim.api.nvim_command([[
"define :Tidy command to run perltidy on visual selection || entire buffer"
command! -range=% -nargs=* Tidy <line1>,<line2>!LC_CTYPE=C LANG=C perltidy

"run :Tidy on entire buffer and return cursor to (approximate) original position"
function! DoTidy()
    let l = line(".")
    let c = col(".")
    :Tidy
    call cursor(l, c)
endfun

"shortcut for normal mode to run on entire buffer then return to current line"
au Filetype perl nmap <Leader>t :call DoTidy()<CR>
"shortcut for visual mode to run on the the current visual selection"
au Filetype perl vmap <Leader>t :Tidy<CR>
]])
--vim.cmd("ruby load '~/.vim/scripts/yamlsort.rb'");

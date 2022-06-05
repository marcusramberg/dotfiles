 vim.api.nvim_command([[

autocmd VimResized * wincmd =

autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100)

au BufRead,BufNewFile *.md,*.markdown setlocal tw=79 fo+=tv

auto BufEnter * :set title
]])

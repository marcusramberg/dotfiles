local m = require'mapx'.setup{ global = true, whichkey = true }

nnoremap("gD", ":lua vim.lsp.buf.declaration()<Cr>", "silent", "LSP: Goto declaration")
nnoremap("gd", ":lua vim.lsp.buf.definition()<Cr>", "silent", "LSP: Goto definition")

nnoremap("<leader> ", ":Buffers<cr>", "Buffers")


m.nname("<leader>b"," +buffers")
nnoremap("<leader>b[",":prev<cr>", "Next")
nnoremap("<leader>b]",":next:q<cr>", "Prev")
nnoremap("<leader>bb",":Buffers<cr>", "Buffers")

m.nname("<leader>c"," +code")
nnoremap("<leader>ca", ":lua vim.lsp.buf.code_action()<cr>", "Action")
nnoremap("<leader>ce", ":lua vim.diagnostic.open_float()<cr>", "Errors")
nnoremap("<leader>c]", ":lua vim.diagnostic.goto_prev()<cr>", "Prev Error")
nnoremap("<leader>c[", ":lua vim.diagnostic.goto.next()<cr>", "Next Error")
nnoremap("<leader>cf", ":lua vim.lsp.buf.formatting()<cr>", "Format")
nnoremap("<leader>cr", ":lua vim.lsp.buf.rename()<CR>", "Format")
nnoremap("<leader>cs",":lua print(vim.inspect(vim.lsp.buf_get_clients()))", "Status")

m.nname("<leader>f", "+file")
nnoremap("<leader>ff", ":Files<cr>", "Find File")
nnoremap("<leader>fb", ":Buffers<cr>", "Buffers")

m.nname("<leader>g", "+git")
nnoremap("<leader>gs", ":Neogit<cr>", "Neogit")
nnoremap("<leader>gf", ":GFiles<cr>", "Git Files")

m.nname("<leader>s", "+search")
nnoremap("<leader>ss", ":Rg <cword><cr>", "Search Selection")
nnoremap("<leader>sS", ":Rg ", "Search ")
nnoremap("<leader>sm", ":EnMasse", "Replace in Hotfix")

m.nname("<leader>t", "tab/translate/tags")
nnoremap("<leader>tn",":tabnew<cr>", "New tab")
nnoremap("<leader>tc",":tabclose<cr>", "Close tab")
nnoremap("<leader>to",":tabonly<cr>", "Close other tabs")
nnoremap("<leader>t]",":tabnext<cr>", "Next tab")
nnoremap("<leader>t[",":tabprevious<cr>", "Prev tab")
nnoremap("<leader>tf",":tabfirst<cr>", "First tab")
nnoremap("<leader>tl",":tablast<cr>", "Last tab")

m.nname("<leader>w", "windows")
nnoremap("<leader>wp", "<C-W>p", "Previous")
nnoremap("<leader>wn", ":vnew<CR>", "New")
nnoremap("<leader>wc", "<C-W>c", "Close")
nnoremap("<leader>wo", "<C-W>o", "One")
nnoremap("<leader>ws", "<C-W>s", "Split")
nnoremap("<leader>wv", "<C-W>v", "Vertical Split")
nnoremap("<leader>ww", "<C-W>w", "Next Window")
nnoremap("<leader>wh", "<C-W>h", "Right")
nnoremap("<leader>wj", "<C-W>j", "Down")
nnoremap("<leader>wl", "<C-W>l", "Left")
nnoremap("<leader>wk", "<C-W>k", "Up")
nnoremap("<leader>w[", "<C-W>5<", "Shrink")
nnoremap("<leader>w]", "<C-W>5>", "Grow")
nnoremap("<leader>w=", ":resize +5<CR>", "Grow")
nnoremap("<leader>w-", ":resize -5<CR>", "Shrink")
nnoremap("<leader>w/", "<C-W>=", "Balance")


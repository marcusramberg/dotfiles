local au = require 'au'
local m = require'mapx'.setup{ whichkey = true } --, global= true }
local nnoremap = m.nnoremap
local ts = require('telescope.builtin')
local org = require('orgmode')

vim.o.pastetoggle="<F2>"

-- " Make mouse clicks a NOOP;
nnoremap('<LeftMouse>', '<nop>')

nnoremap("gD", function() vim.lsp.buf.declaration() end, "silent", "LSP: Goto declaration")
nnoremap("gd", function() vim.lsp.buf.definition() end, "silent", "LSP: Goto definition")
nnoremap("gr", function() vim.lsp.buf.references() end, "silent", "LSP: Goto references")
nnoremap("gi", function() vim.lsp.buf.implementation() end, "silent", "LSP: Goto implementation")
nnoremap("K", function() vim.lsp.buf.hover() end, "silent", "hover")
nnoremap("[e", function() vim.diagnostic.goto_prev() end, "silent", "Prev Error")
nnoremap("]e", function() vim.diagnostic.goto_next() end, "silent", "Next Error")

nnoremap("<leader> ", function() ts.buffers() end, "Buffers")


m.nname("<leader>b"," +buffers")
nnoremap("<leader>b[",":prev<cr>", "Next")
nnoremap("<leader>b]",":next:q<cr>", "Prev")
nnoremap("<leader>bb", function() ts.buffers() end, "Buffers")

m.nname("<leader>c"," +code")
nnoremap("<leader>ca", function() ts.lsp_code_actions() end, "silent", "Action")
nnoremap("<leader>ce", function() vim.diagnostic.open_float() end, "silent", "Errors")
nnoremap("<leader>cf", function() vim.lsp.buf.formatting() end, "silent", "Format")
nnoremap("<leader>cr", function() vim.lsp.buf.rename() end, "silent", "Format")
nnoremap("<leader>cs", function() print(vim.inspect(vim.lsp.buf_get_clients())) end, "silent", "Status")

m.nname("<leader>f", "+file")
nnoremap("<leader>ff", ":Files<cr>", "Find File")
nnoremap("<leader>fb", ":Buffers<cr>", "Buffers")

m.nname("<leader>g", "+git")
nnoremap("<leader>gs", ":Neogit kind=vsplit<cr>", "Neogit")
nnoremap("<leader>gf", ":GFiles<cr>", "Git Files")
nnoremap("<leader>gi", ":Octo issue list<cr>", "issues")
nnoremap("<leader>gp", ":Octo pr list<cr>", "prs")

m.nname("<leader>h", "+help")
nnoremap("<leader>hh", function() ts.help_tags() end, "help")


m.nname("<leader>o", "+open")
nnoremap("<leader>ot", ":ToggleTerm<cr>", "Terminal")
nnoremap("<leader>oa", function() org.action("agenda.prompt") end, "Agenda")
nnoremap("<leader>oc", function() org.action("capture.prompt") end, "Capture")

m.nname("<leader>s", "+search")
nnoremap("<leader>ss", ":Rg <cword><cr>", "Search Selection")
nnoremap("<leader>sS", ":Rg ", "Search ")
nnoremap("<leader>sm", ":EnMasse", "Replace in Hotfix")

m.nname("t", "tab")
nnoremap("tn",":tabnew<cr>", "New tab")
nnoremap("tc",":tabclose<cr>", "Close tab")
nnoremap("to",":tabonly<cr>", "Close other tabs")
nnoremap("t]",":tabnext<cr>", "Next tab")
nnoremap("t[",":tabprevious<cr>", "Prev tab")
nnoremap("tf",":tabfirst<cr>", "First tab")
nnoremap("tl",":tablast<cr>", "Last tab")

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

-- " Tab navigation
local lasttab = 1
nnoremap('tt', function() vim.call('tabn',lasttab) end, 'last tab')

 au.TabLeave  = function()
  lasttab = vim.fn.tabpagenr()
 end
nnoremap('<C-p>', function()  ts.find_files() end)
nnoremap('<C-r>', function()  ts.command_history() end)

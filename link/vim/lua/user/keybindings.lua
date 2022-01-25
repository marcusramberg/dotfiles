local m = require'mapx'.setup{ } --whichkey = true, global= true }
local nnoremap = m.nnoremap
local au = require 'au'
local vimp = require'vimp'

vim.o.pastetoggle="<F2>"

-- " Make mouse clicks a NOOP;
nnoremap('<LeftMouse>', '<nop>')


nnoremap("gD", function() vim.lsp.buf.declaration() end, "silent", "LSP: Goto declaration")
nnoremap("gd", function() vim.lsp.buf.definition() end, "silent", "LSP: Goto definition")
nnoremap("[e", function() vim.diagnostic.goto_prev() end, "silent", "Prev Error")
nnoremap("]e", function() vim.diagnostic.goto_next() end, "silent", "Next Error")

nnoremap("<leader> ", ":Buffers<cr>", "Buffers")

nnoremap('<leader>r', function()
  -- Remove all previously added vimpeccable maps
  vimp.unmap_all()
  -- Unload the lua namespace so that the next time require('config.X') is called
  -- it will reload the file
  require("config.util").unload_lua_namespace('config')
  -- Make sure all open buffers are saved
  vim.cmd('silent wa')
  -- Execute our vimrc lua file again to add back our maps
  dofile(vim.fn.stdpath('config') .. '/init.lua')

  print("Reloaded vimrc!")
end, "reload")


m.nname("<leader>b"," +buffers")
nnoremap("<leader>b[",":prev<cr>", "Next")
nnoremap("<leader>b]",":next:q<cr>", "Prev")
nnoremap("<leader>bb",":Buffers<cr>", "Buffers")

m.nname("<leader>c"," +code")
nnoremap("<leader>ca", function() vim.lsp.buf.code_action() end, "silent", "Action")
nnoremap("<leader>ce", function() vim.diagnostic.open_float() end, "silent", "Errors")
nnoremap("<leader>cf", function() vim.lsp.buf.formatting() end, "silent", "Format")
nnoremap("<leader>cr", function() vim.lsp.buf.rename() end, "silent", "Format")
nnoremap("<leader>cs", function() print(vim.inspect(vim.lsp.buf_get_clients())) end, "silent", "Status")

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
-- local lasttab = 1
-- nnoremap('<leader>tt', function() return ':tabn "'..lasttab..'<CR>' end, 'last tab')

--  au.TabLeave  = function()
--   lasttab = vim.fn.tabpagenr()
--    print(lasttab)
--  end
-- nnoremap('<C-p>', ':FZF<Cr>')

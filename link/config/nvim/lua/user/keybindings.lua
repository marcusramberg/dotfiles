local au = require 'au'
local m = require'mapx'.setup{ whichkey = true } --, global= true }
local nnoremap = m.nnoremap
local ts = require('telescope.builtin')
local tse = require('telescope').extensions
local org = require('orgmode')

vim.o.pastetoggle="<F2>"

-- " Make mouse clicks a NOOP;
-- nnoremap('<LeftMouse>', '<nop>')

nnoremap("<leader> ", function() ts.buffers() end, "Buffers")
nnoremap("<leader>,", ":AerialToggle<cr>", "Navigate")
nnoremap("<leader>.", ":b#<cr>", "Last Buffer")


m.nname("<leader>b","buffers")
nnoremap("<leader>bd",":bd<cr>", "Delete")
nnoremap("<leader>b[",":bp<cr>", "Prev")
nnoremap("<leader>b]",":bn<cr>", "Next")
nnoremap("<leader>bb", function() ts.buffers() end, "Buffers")
nnoremap("[b",":bp<cr>", "Prev Buffer")
nnoremap("]b",":bn<cr>", "Next Buffer")
nnoremap("<leader>z",":Lazy<cr>", "Packages")
nnoremap("<leader>Z",":Mason<cr>", "LSP Packages")

m.nname("<leader>c","code")
nnoremap("<leader>ca", "<cmd>Lspsaga code_action<CR>", "silent", "Action")

vim.keymap.set("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true })
nnoremap("<leader>cl", function() require'lsp_menu'.codelens.run{} end, "silent", "Lens") --ts.lsp_code_actions() end, "silent", "Action")
nnoremap("<leader>ce", function() vim.diagnostic.open_float() end, "silent", "Errors")
nnoremap("<leader>cr", function() vim.lsp.buf.rename() end, "silent", "Format")
nnoremap("<leader>cs", function() print(vim.inspect(vim.lsp.buf_get_clients())) end, "silent", "Status")
nnoremap("<leader>cy", ":Telescope yaml_schema<cr>", "YAML Schema")

m.nname("<leader>f", "file")
nnoremap("<leader>fb", function() ts.buffers() end, "Buffers")
nnoremap("<leader>ff", function() ts.find_files() end,  "Find File")
nnoremap("<leader>fr", function() ts.oldfiles() end, "Recent")

m.nname("<leader>g", "git")
-- nnoremap("<leader>gb", ":GitBlameToggle<cr>", "Neogit")
nnoremap("<leader>gs", ":Neogit kind=vsplit<cr>", "Neogit")
nnoremap("<leader>gg", ":Neogit kind=vsplit<cr>", "Neogit")
nnoremap("<leader>gf", ":GFiles<cr>", "Git Files")
nnoremap("<leader>gi", ":Octo issue list<cr>", "issues")
nnoremap("<leader>gp", ":Octo pr list<cr>", "prs")

m.nname("<leader>h", "help")
nnoremap("<leader>hh", function() ts.help_tags() end, "help")
nnoremap("<leader>hd", ":DashWord<cr>" , "dash")
nnoremap("<leader>hc", ":CheatList<cr>" , "help")
nnoremap("<leader>hC", ":Cheat" , "help")

m.nname("<leader>o", "open")
nnoremap("<leader>ot", function() require('neoterm').toggle() end, "Terminal")
nnoremap("<leader>A", function() org.action("agenda.prompt") end, "Agenda")
nnoremap("<leader>C", function() org.action("capture.prompt") end, "Capture")

m.nname("<leader>p", "project")
nnoremap("<leader>pp", function() tse.project.project{ display_type = "full" } end, "Switch")

m.nname("<leader>s", "search")
nnoremap("<leader>sS", ":Rg <cword><cr>", "Search Selection")
nnoremap("<leader>ss", ":Telescope live_grep<cr>", "Live")
nnoremap("<leader>sw", ":Telescope grep_string<cr>", "Word")
nnoremap("<leader>sr", ":Telescope resume<cr>", "Resume Telescope")
nnoremap("<leader>sm", ":EnMasse", "Replace in Hotfix")

m.nname("t", "tab")
nnoremap("tn",":tabnew<cr>", "New tab")
nnoremap("tc",":tabclose<cr>", "Close tab")
nnoremap("to",":tabonly<cr>", "Close other tabs")
nnoremap("]t",":tabnext<cr>", "Next tab")
nnoremap("[t",":tabprevious<cr>", "Prev tab")
nnoremap("tf",":tabfirst<cr>", "First tab")
nnoremap("tl",":tablast<cr>", "Last tab")
local prevtab = 1
nnoremap('tt', function() vim.cmd(string.format("tabn %s",prevtab)) end, 'Prev tab')
au.TabLeave  = function() prevtab = vim.fn.tabpagenr() end

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

m.nname("<leader>x", "trouble")
nnoremap("<leader>xx", "<cmd>TroubleToggle<cr>","Toggle Trouble")
nnoremap("<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>","Workspace Diag")
nnoremap("<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>","Document Diag")
nnoremap("<leader>xq", "<cmd>TroubleToggle quickfix<cr>","Quickfix")
nnoremap("<leader>xl", "<cmd>TroubleToggle loclist<cr>","Loc List")
nnoremap("gR", "<cmd>TroubleToggle lsp_references<cr>","LSP References")

nnoremap('<C-p>', function()  ts.find_files() end)

nnoremap("gD", function() vim.lsp.buf.declaration() end, "silent", "LSP: Goto declaration")
nnoremap("gd", function() vim.lsp.buf.definition() end, "silent", "LSP: Goto definition")
nnoremap("gr", function() ts.lsp_references() end, "silent", "LSP: Goto references")
nnoremap("gi", function() vim.lsp.buf.implementation() end, "silent", "LSP: Goto implementation")
nnoremap("K", function() vim.lsp.buf.hover() end, "silent", "hover")
nnoremap("[e", function() vim.diagnostic.goto_prev() end, "silent", "Prev Error")
nnoremap("]e", function() vim.diagnostic.goto_next() end, "silent", "Next Error")


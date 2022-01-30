vim.o.clipboard = 'unnamedplus'
vim.o.cmdheight = 2
-- nevertabs
vim.o.expandtab = true
-- smartcase
vim.o.ignorecase = true
vim.o.smartcase = true
-- Have background buffers
vim.o.hidden = true
-- more history
vim.o.history = 1000
-- highlight search
vim.o.hlsearch = true
-- increment search
vim.o.incsearch = true
vim.o.infercase = true
-- Enable mouse mode for scrolling
vim.o.mouse = "a"
vim.o.number = true

-- Avoid syntax highlighting very long lines
vim.o.synmaxcol = 300

-- 2 space lyfe
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2

-- Show matching brace
vim.o.showmatch = true
-- Always include sign column
vim.o.signcolumn = "yes"

-- split sanely
vim.o.splitright = true
vim.o.splitbelow = true

-- Show unprintable
vim.olist = true -- Display unprintable characters f12 - switches
vim.o.listchars = 'tab:• ,trail:•,extends:»,precedes:«' -- Unprintable chars mapping

-- 24 bit colors

vim.o.termguicolors = true

local wk = require("which-key")


local which_key_map = {}

which_key_map.b = {
  ["name"] = "+file",
  ["["] = { "<cmd>prev<cr>", "Next" },
  ["]"] = { "<cmd>next:q<cr>", "Prev" },
  ["b"] = { "<cmd>Buffers<cr>", "Buffers" },
}
which_key_map.c = {
  ["a"] = { "<Cmd>lua vim.lsp.buf.code_action()<cr>", "Action" },
  ["e"] = { "<Cmd>lua vim.diagnostic.open_float()<cr>", "Errors" },
  ["]"] = { "<Cmd>lua vim.diagnostic.goto_prev()<cr>", "Next Error" },
  ["["] = { "<Cmd>lua vim.diagnostic.goto.next()<cr>", "Buffers" },
  ["f"] = { "<Cmd>lua vim.lsp.buf.formatting()<cr>", "Formatting" }
}
which_key_map.f = {
  ["name"] = "+file",
  ["f"] = { "<Cmd>Files<cr>", "Find File" },
  ["b"] = { "<Cmd>Buffers<cr>", "Buffers" },
}
which_key_map.g = {
  ["name"] = "git",
  ["g"] = { "<cmd>Neogit<cr>", "Neogit"},
  ["f"] = { "<cmd>GFiles<cr>", "Git Files"},
}

which_key_map.t = {
  ["name"] = "tab/translate/tags",
  ["n"] = {"<cmd>tabnew<cr>", "new tab"},
  ["c"] = {"<cmd>tabclose<cr>", "close tab"},
  ["o"] = {"<cmd>tabonly<cr>", "close other tabs"},
  ["]"] = {"<cmd>tabnext<cr>", "next tab"},
  ["["] = {"<cmd>tabprevious<cr>", "prev tab"},
  ["f"] = {"<cmd>tabfirst<cr>", "first tab"},
  ["l"] = {"<cmd>tablast<cr>", "last tab"},
}

which_key_map.w = {
  ["name"] = "windows",
  ["p"] = {"<C-W>p", "Previous"},
  ["n"] = {"<Cmd>vnew<CR>", "New"},
  ["c"] = {"<C-W>c", "Close"},
  ["o"] = {"<C-W>o", "One"},
  ["s"] = {"<C-W>s", "Split"},
  ["v"] = {"<C-W>v", "Vertical Split"},
  ["w"] = {"<C-W>w", "Next Window"},
  ["h"] = {"<C-W>h", "Right"},
  ["j"] = {"<C-W>j", "Down"},
  ["l"] = {"<C-W>l", "Left"},
  ["k"] = {"<C-W>k", "Up"},
  ["["] = {"<C-W>5<", "Shrink"},
  ["]"] = {"<C-W>5>", "Grow"},
  ["="] = {"<Cmd>resize +5<CR>", "Grow"},
  ["-"] = {"<Cmd>resize -5<CR>", "Shrink"},
  ["/"] = {"<C-W>=", "Balance"},
}

wk.register(which_key_map, {prefix = "<Leader>"})

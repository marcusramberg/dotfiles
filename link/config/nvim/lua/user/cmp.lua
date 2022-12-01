local cmp = require('cmp')
local cmp_kinds = {
	Text          = ' ',
	Method        = ' ',
	Function      = ' ',
	Constructor   = ' ',
	Field         = '識',
	Variable      = '𝑋 ',
	Class         = ' ',
	Interface     = ' ',
	Module        = ' ',
	Property      = ' ',
	Unit          = ' ',
	Value         = ' ',
	Enum          = ' ',
	Keyword       = ' ',
	Snippet       = '﬌ ',
	Color         = ' ',
	File          = ' ',
	Reference     = ' ',
	Folder        = ' ',
	EnumMember    = ' ',
	Constant      = ' ',
	Struct        = ' ',
	Event         = ' ',
	Operator      = 'ﬦ' ,
	TypeParameter = ' ',
}

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end
cmp.setup {
	completion = {
		completeopt = 'menu,menuone,noinsert',
	},

	formatting = {
		format = function(_, vim_item)
			vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
			return vim_item
		end,
	},

	snippet = {
		expand = function(args)
			vim.fn['vsnip#anonymous'](args.body)
		end,
	},

	mapping = {
		['<up>'] = cmp.mapping.select_prev_item(),
		['<down>'] = cmp.mapping.select_next_item(),
		["<C-g>"] = cmp.mapping.complete(),
		['<C-k>'] = cmp.mapping.select_prev_item(),
		['<C-j>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},

		["<Tab>"] = vim.schedule_wrap(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
			elseif vim.fn["vsnip#available"]() == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				cmp.complete()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
	},

	sources = {
    { name = "copilot",  group_index = 2 },
		{ name = 'path'     },
		{ name = 'vsnip'    },
		{ name = 'orgmode' },
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'git'      },
		{ name = 'buffer',
			option = {
				get_bufnrs = function()
					local bufs = {}
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						bufs[vim.api.nvim_win_get_buf(win)] = true
					end
					return vim.tbl_keys(bufs)
				end
			}
		},
		{ name = 'emoji' }
	},
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
	-- Syntax
	-- use 'zah/nim.vim'
	"sheerun/vim-polyglot",
	"golang/vscode-go",
	"elzr/vim-json",
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		config = function()
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.gotmpl = {
				install_info = {
					url = "https://github.com/ngalaiko/tree-sitter-go-template",
					files = { "src/parser.c" },
				},
				filetype = "gotmpl",
				used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" },
			}
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({})
		end,
	},
	{
		"nathom/filetype.nvim",
		config = function()
			require("filetype").setup({
				overrides = {
					extensions = {
						tf = "terraform",
						tfvars = "terraform",
						tfstate = "json",
					},
				},
			})
		end,
	},
	{
		"nvim-orgmode/orgmode",
		config = function()
			require("orgmode").setup_ts_grammar()
			require("orgmode").setup({
				require("orgmode").setup({
					org_agenda_files = "~/org/**",
					org_default_notes_file = "~/org/inbox.org",
					org_hide_leading_stars = true,
				}),
			})
			require("nvim-treesitter.configs").setup({
				-- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
				highlight = {
					enable = true,
					disable = { "org" }, -- Remove this to use TS highlighter for some of the highlights (Experimental)
					additional_vim_regex_highlighting = { "org" }, -- Required since TS highlighter doesn't support all syntax features (conceal)
				},
				ensure_installed = { "org" }, -- Or run :TSUpdate org
			})
		end,
	},

	"akinsho/org-bullets.nvim",
	"wsdjeg/luarefvim",

	-- Extend editing
	"adelarsq/vim-matchit",
	"907th/vim-auto-save",
	{
		"sQVe/sort.nvim",
		config = function()
			require("sort").setup({})
		end,
	},
	"christianrondeau/vim-base64",
	"andymass/vim-matchup",
	"rhysd/clever-f.vim",

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-project.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "olacin/telescope-gitmoji.nvim" },
		},
		config = function()
			local t = require("telescope")
			t.setup({
				defaults = {},
				pickers = {
					buffers = { theme = "ivy" },
					find_files = { theme = "ivy" },
					live_grep = { theme = "ivy" },
					spell_suggest = { theme = "ivy" },
				},
				extensions = {
					project = {
						theme = "dropdown",
						base_dirs = {
							"~/Source",
						},
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			-- t.load_extension('project')
			t.load_extension("ui-select")
			t.load_extension("gitmoji")
		end,
	},

	-- Version Control
	{
		"TimUntersberger/neogit",
		config = function()
			require("neogit").setup({ use_magit_keybindings = true })
		end,
		dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
	},
	{ "akinsho/git-conflict.nvim", config = true },
	"f-person/git-blame.nvim",

	{
		"pwntester/octo.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "kyazdani42/nvim-web-devicons" },
		config = true,
	},

	-- Help

	{ "RishabhRD/nvim-cheat.sh", dependencies = { "RishabhRD/popfix" } },

	-- open with line (from syntax output and such)
	"wsdjeg/vim-fetch",
	-- menus
	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				plugins = {
					spelling = {
						enabled = true,
					},
				},
				icons = {
					breadcrumb = "", -- symbol used in the command line area that shows your active key combo
					separator = "", -- symbol used between a key and it's label
					group = "…",
				},
				window = {
					border = "single",
				},
			})
		end,
	},
	{ "stevearc/overseer.nvim", config = true },

	-- LSP
	-- 'ThePrimeagen/refactoring.nvim',
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local sources = {
				-- null_ls.builtins.code_actions.refactoring,
				null_ls.builtins.code_actions.shellcheck,
				null_ls.builtins.formatting.terraform_fmt,
				null_ls.builtins.diagnostics.actionlint,
				null_ls.builtins.diagnostics.codespell,
				null_ls.builtins.diagnostics.cppcheck,
				null_ls.builtins.diagnostics.deadnix,
				null_ls.builtins.diagnostics.gitlint,
				null_ls.builtins.diagnostics.golangci_lint,
				null_ls.builtins.diagnostics.jsonlint,
				null_ls.builtins.diagnostics.tidy,
				null_ls.builtins.diagnostics.vale,
				null_ls.builtins.diagnostics.write_good,
				null_ls.builtins.diagnostics.yamllint,
				null_ls.builtins.formatting.prettier,
			}
			null_ls.setup({ sources = sources, debug = true })
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "chrisgrieser/nvim-recorder", config = true },
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.comment").setup({})
			require("mini.surround").setup({})
		end,
	},
	"vigoux/LanguageTool.nvim",

	"neovim/nvim-lspconfig",
	-- 'arkav/lualine-lsp-progress',
	{
		"glepnir/lspsaga.nvim",
		event = "BufRead",
		config = function()
			require("lspsaga").setup({
				-- your configuration
				code_action_lightbulb = { virtual_text = false },
			})
		end,
	},
	"b0o/schemastore.nvim",
	{ "williamboman/mason.nvim", config = true },
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls",
					"terraformls",
					"tflint",
					"tsserver",
				},
			})
			require("user.lsp-config")
		end,
	},
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },

	"aspeddro/lsp_menu.nvim",
	{
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup({
				layout = {
					default_direction = "prefer_left",
				},
				close_on_select = true,
			})
		end,
	},
	-- yaml companion
	{
		"someone-stole-my-name/yaml-companion.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("telescope").load_extension("yaml_schema")
			local cfg = require("yaml-companion").setup({
				schemas = {
					result = {
						{
							name = "Kubernetes 1.22.4",
							uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json",
						},
						{
							name = "Taskfile",
							uri = "https://gist.githubusercontent.com/KROSF/c5435acf590acd632f71bb720f685895/raw/6f11aa982ad09a341e20fa7f4beed1a1b2a8f40e/taskfile.schema.json",
						},
						{
							name = "Helmfile",
							url = "https://raw.githubusercontent.com/hiberbee/yamlschema/master/src/schemas/helm/helmfile.yaml.json",
						},
						{
							name = "OpenAPI",
							url = "https://github.com/OAI/OpenAPI-Specification/blob/main/schemas/v3.1/schema.yaml",
						},
					},
				},
			})
			require("lspconfig")["yamlls"].setup(cfg)
		end,
	},
	"windwp/nvim-spectre",

	-- Autocomplete

	-- use 'github/copilot.vim'
	{
		"zbirenbaum/copilot.lua",
		event = "VimEnter",
		config = function()
			vim.defer_fn(function()
				require("copilot").setup({
					copilot_node_command = vim.fn.expand("$HOME") .. "/.local/share/nvm/v17.9.1/bin/node", -- Node version must be < 18
				})
			end, 100)
		end,
	},

	{ "zbirenbaum/copilot-cmp", config = true },
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"hrsh7th/vim-vsnip-integ",
			"prabirshrestha/vsnip-snippets",
			"prabirshrestha/vsnip-snippets",
			"petertriho/cmp-git",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
	},
	"rafamadriz/friendly-snippets",

	{
		"folke/trouble.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	},
	-- {
	--   'mrjones2014/dash.nvim',
	--   enabled = (jit.os == 'OSX'),
	-- },
	-- Terminal
	{
		"itmecho/neoterm.nvim",
		config = function()
			require("neoterm").setup({
				mode = "horizontal",
				noinsert = true,
			})
		end,
	},

	{
		"akinsho/bufferline.nvim",
		version = ">=3",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					separator_style = "thick",
					diagnostics = "nvim_lsp",
				},
			})
		end,
	},

	{ "tiagovla/scope.nvim", config = true },

	-- Styling
	{ "lewis6991/gitsigns.nvim", config = true },
	{
		"folke/tokyonight.nvim",
		config = function()
			vim.cmd("colorscheme tokyonight")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
					globalstatus = true,
					theme = "tokyonight",
				},
				sections = {
					lualine_a = {
						{
							"mode",
							fmt = function(str)
								return str:sub(1, 1)
							end,
						},
					},
					lualine_b = { "branch" },
					lualine_c = { "filename", "lsp_progress" },
					lualine_x = { "aerial", "fileformat", "filetypes" },
				},
			})
		end,
	},
	"b0o/mapx.nvim",
	{
		"jackMort/pommodoro-clock.nvim",
		config = function()
			require("pommodoro-clock").setup({ say_command = "say" })
		end,
		dependencies = { "MunifTanjim/nui.nvim" },
	},
	{
		"folke/noice.nvim",
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
			})
		end,
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	},
})
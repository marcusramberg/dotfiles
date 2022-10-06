local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

-- Bootstrap
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer = require 'packer'

packer.init { max_jobs = tonumber(vim.fn.system 'nproc') or 8 }

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Syntax
  use 'sheerun/vim-polyglot'
  -- use 'zah/nim.vim'
  use 'golang/vscode-go'
  use 'elzr/vim-json'
  use { 'nvim-treesitter/nvim-treesitter', run = 'TSUpdate' }
  use { 'nvim-treesitter/nvim-treesitter-context', config = function() require 'treesitter-context'.setup {} end }
  use { 'nvim-orgmode/orgmode', config = function()
    require('orgmode').setup_ts_grammar()
    require('orgmode').setup {
      require("orgmode").setup({
          org_agenda_files = "~/org/**",
          org_default_notes_file = "~/org/inbox.org",
          org_hide_leading_stars = true,
        })
    }
    require 'nvim-treesitter.configs'.setup {
      -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
      highlight = {
        enable = true,
        disable = { 'org' }, -- Remove this to use TS highlighter for some of the highlights (Experimental)
        additional_vim_regex_highlighting = { 'org' }, -- Required since TS highlighter doesn't support all syntax features (conceal)
      },
      ensure_installed = { 'org' }, -- Or run :TSUpdate org
    }
  end }

  use 'akinsho/org-bullets.nvim'
  use 'wsdjeg/luarefvim'

  -- return where you came from
  use 'farmergreg/vim-lastplace'

  -- Extend editing
  use 'adelarsq/vim-matchit'
  use 'terryma/vim-multiple-cursors'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use '907th/vim-auto-save'
  use 'karb94/neoscroll.nvim'
  use({ 'sQVe/sort.nvim', config = function() require("sort").setup({}) end })
  use 'christianrondeau/vim-base64'
  use 'szw/vim-g'
  use 'rhysd/clever-f.vim'


  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-project.nvim' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'olacin/telescope-gitmoji.nvim' },
    },
    config = function()
      local t = require "telescope"
      t.setup {
        pickers = {
          buffers       = { theme = 'ivy' },
          find_files    = { theme = 'ivy' },
          live_grep     = { theme = 'ivy' },
          spell_suggest = { theme = 'ivy' },
        },
        extensions = {
          project = {
            theme = 'dropdown',
            base_dirs = {
              '~/Source',
            }
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          }
        },
      }
      -- t.load_extension('project')
      t.load_extension('ui-select')
      t.load_extension('gitmoji')
    end
  }

  -- Version Control
  use {
    'TimUntersberger/neogit',
    config = function() require "neogit".setup { use_magit_keybindings = true } end,
    requires = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' }
  }
  use 'f-person/git-blame.nvim'
  use {
    'pwntester/octo.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim', 'kyazdani42/nvim-web-devicons' },
    config = function() require "octo".setup() end
  }

  -- Help

  use { 'RishabhRD/nvim-cheat.sh', requires = { 'RishabhRD/popfix' } }

  -- open with line (from syntax output and such)
  use 'bogado/file-line'
  -- menus
  use { 'folke/which-key.nvim', config = function()
    require("which-key").setup {
      plugins = {
        spelling = {
          enabled = true
        }
      },
      icons = {
        breadcrumb = "", -- symbol used in the command line area that shows your active key combo
        separator = "", -- symbol used between a key and it's label
        group = "…"
      },
      window = {
        border = "single",
      }

    }
  end
  }
  use {
    'stevearc/overseer.nvim',
    config = function() require('overseer').setup() end
  }

  -- LSP
  use 'ThePrimeagen/refactoring.nvim'
  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      local sources = {
        -- null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.code_actions.shellcheck,
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
        null_ls.builtins.formatting.terrafmt,
      }
      null_ls.setup({ sources = sources, debug = true })
    end,
    requires = { "nvim-lua/plenary.nvim" },
  })
  use "neovim/nvim-lspconfig"
  use 'arkav/lualine-lsp-progress'
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      local saga = require("lspsaga")

      saga.init_lsp_saga({
        -- your configuration
        code_action_lightbulb = { virtual_text = false, }
      })
    end,
  })
  use "b0o/schemastore.nvim"
  use { "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
      require 'user.lsp-config'
    end
  }
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

  use 'aspeddro/lsp_menu.nvim'
  use { 'stevearc/aerial.nvim', config = function() require('aerial').setup({
      default_direction = "prefer_left",
      close_on_select = true,

    })
  end }
  -- yaml companion
  use {
    "someone-stole-my-name/yaml-companion.nvim",
    requires = {
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
              url = "https://raw.githubusercontent.com/hiberbee/yamlschema/master/src/schemas/helm/helmfile.yaml.json"
            },
            {
              name = "OpenAPI",
              url = "https://github.com/OAI/OpenAPI-Specification/blob/main/schemas/v3.1/schema.yaml"
            }
          },
        },
      })
      require("lspconfig")["yamlls"].setup(cfg)
    end,
  }
  use 'windwp/nvim-spectre'

  -- Autocomplete

  use 'github/copilot.vim'
  use { 'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua', 'hrsh7th/cmp-vsnip', 'hrsh7th/vim-vsnip', 'hrsh7th/vim-vsnip-integ',
      'prabirshrestha/vsnip-snippets', 'prabirshrestha/vsnip-snippets', 'petertriho/cmp-git', 'hrsh7th/cmp-copilot', 'hrsh7th/cmp-emoji', 'hrsh7th/cmp-nvim-lsp-signature-help'},
  }
  use "rafamadriz/friendly-snippets"



  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }

  if (jit.os == "OSX") then
    use({
      'mrjones2014/dash.nvim',
      run = 'make install',
    })
  end

  -- Terminal
  use {
    's1n7ax/nvim-terminal',
    config = function()
        vim.o.hidden = true
        require('nvim-terminal').setup()
    end,
}

  use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require("bufferline").setup { options = {
        separator_style = "thick",
        diagnostics = "nvim_lsp",
      }
      }
    end
  }

  use { "tiagovla/scope.nvim", config = function()
    require("scope").setup()
  end }

  -- Styling
  use { 'lewis6991/gitsigns.nvim', config = function()
    require('gitsigns').setup()
  end }
  use  { 'shaunsingh/nord.nvim', config = function ()
    vim.cmd[[ colorscheme nord ]]
  end }


  -- use { 'EdenEast/nightfox.nvim', config = function()
  --   require('nightfox').setup({
  --     options = {
  --       -- Compiled file's destination location
  --       compile_path = vim.fn.stdpath("cache") .. "/nightfox",
  --       compile_file_suffix = "_compiled", -- Compiled file suffix
  --       transparent = true, -- Disable setting background
  --       terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
  --       dim_inactive = true,
  --     },
  --     palettes = {
  --       nordfox = {
  --         sel0 = "#3e4a5b", -- Popup bg, visual selection bg
  --       }
  --     }
  --   })
  --   vim.cmd [[colorscheme nordfox]]
  -- end
  -- }

  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            { 'mode', fmt = function(str) return str:sub(1, 1) end }
          },
          lualine_b = { 'branch' },
          lualine_c = { 'filename', 'lsp_progress' },
          lualine_x = { 'aerial', 'fileformat', 'filetypes' },
        }
      }
    end
  }
  use 'b0o/mapx.nvim'
end)

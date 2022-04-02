local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

-- Bootstrap
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer = require 'packer'
local use = packer.use

packer.init {max_jobs = tonumber(vim.fn.system 'nproc') or 8}

packer.startup(function()
  use 'wbthomason/packer.nvim'

  -- fzf <3
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'

  -- Syntax
  use 'sheerun/vim-polyglot'
  use 'burner/vim-svelte'
  use 'elzr/vim-json'
  use 'w0rp/ale'
  use {'nvim-treesitter/nvim-treesitter', run = 'TSUpdate'}
  use {'nvim-orgmode/orgmode', config = function() require('orgmode').setup {} end}
  use 'akinsho/org-bullets.nvim'
  use 'wsdjeg/luarefvim'

  -- Search/replace
  use 'Olical/vim-enmasse'
  use 'jremmen/vim-ripgrep'

  -- Extend editing
  use 'adelarsq/vim-matchit'
  use 'terryma/vim-multiple-cursors'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use '907th/vim-auto-save'

  -- Version Control
  use {
    'TimUntersberger/neogit',
    config = function() require"neogit".setup {use_magit_keybindings = true} end,
    requires = {'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim'}
  }
  use {
    'pwntester/octo.nvim',
    requires = {'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim', 'kyazdani42/nvim-web-devicons'},
    config = function() require"octo".setup() end
  }

  -- Help

  use {'RishabhRD/nvim-cheat.sh', requires = {'RishabhRD/popfix'}}

  -- open with line (from syntax output and such)
  use 'bogado/file-line'
  -- menus
  use 'folke/which-key.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  -- Progress bar
  use {'j-hui/fidget.nvim', config = function() require"fidget".setup {} end}
  -- Autocomplete
  use 'nvim-lua/popup.nvim'
  use {'ms-jpq/coq_nvim', branch = 'coq'}

  -- 9000+ Snippets
  use {'ms-jpq/coq.artifacts', branch = 'artifacts'}
  use {'ms-jpq/coq.thirdparty', branch = '3p'}

  -- Terminal
  use 'akinsho/toggleterm.nvim'

  -- Styling
  use 'airblade/vim-gitgutter'
  use {'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function ()
      require('lualine').setup{
        options = {
          theme = 'nord',
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' }
        }
      }
    end
  }
  use 'dracula/vim'
  use 'b0o/mapx.nvim'
  use {'shaunsingh/nord.nvim', config = function ()
    vim.cmd[[colorscheme nord]]
  end}
 end)

-- packer.use_rocks {
--   'base64',
-- }

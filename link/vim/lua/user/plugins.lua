local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer = require 'packer'
local use = packer.use

packer.init {
  max_jobs = tonumber(vim.fn.system 'nproc') or 8,
}

packer.startup(function()
  use 'wbthomason/packer.nvim'

  use 'svermeulen/vimpeccable'

  -- fzf <3
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'

  -- Syntax
  use 'sheerun/vim-polyglot'
  use 'burner/vim-svelte'
  use 'elzr/vim-json'
  use 'w0rp/ale'
  use {'nvim-treesitter/nvim-treesitter', run='TSUpdate'}
  use {'nvim-orgmode/orgmode', config = function() require('orgmode').setup{} end }
  use 'akinsho/org-bullets.nvim'


  -- Search/replace
  use 'Olical/vim-enmasse'
  use 'jremmen/vim-ripgrep'

  -- Extend editing
  use 'adelarsq/vim-matchit'
  use 'terryma/vim-multiple-cursors'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'Pocco81/AutoSave.nvim'

  -- Version Control
  use 'nvim-lua/plenary.nvim'
  use 'TimUntersberger/neogit'
  use 'sindrets/diffview.nvim'

  -- Navigation
  use 'bogado/file-line'

  -- Autocomplete
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/completion-nvim'
  use 'nvim-lua/popup.nvim'
  use { 'ms-jpq/coq_nvim', branch = 'coq' }
  -- 9000+ Snippets
  use {'ms-jpq/coq.artifacts', branch='artifacts'}
  use {'ms-jpq/coq.thirdparty', branch='3p'}

  -- Terminal
  use 'akinsho/toggleterm.nvim'

  -- Styling
  use 'airblade/vim-gitgutter'
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  require('lualine').setup()
  use 'dracula/vim'
  use 'folke/which-key.nvim'
  use 'b0o/mapx.nvim'
  use({
      "themercorp/themer.lua",
      config = function()
        require("themer").setup({
            colorscheme = "dracula",
            styles = {
              comment = { style = 'italic' },
              ["function"] = { style = 'italic' }, 
              functionbuiltin = { style = 'italic' }, 
              variable = { style = 'italic' }, 
              variableBuiltIn = { style = 'italic' }, 
              parameter  = { style = 'italic' }, 
            },
          })
      end
    })
  end)

-- packer.use_rocks {
--   'base64',
-- }

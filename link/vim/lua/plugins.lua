vim.cmd [[packadd packer.nvim]]

return require 'packer'.startup(function()
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
  use 'kristijanhusak/orgmode.nvim'
  use {'nvim-treesitter/nvim-treesitter', run='TSUpdate'}


-- Search/replace
  use 'Olical/vim-enmasse'
  use 'jremmen/vim-ripgrep'

-- Extend editing
  use 'adelarsq/vim-matchit'
  use 'terryma/vim-multiple-cursors'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'

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


-- Styling
  use 'airblade/vim-gitgutter'
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  require('lualine').setup()
  use 'dracula/vim'
  use 'folke/which-key.nvim'
  use 'b0o/mapx.nvim'
  use 'themercorp/themer.lua'
end)


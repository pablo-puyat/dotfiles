vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'folke/tokyonight.nvim'
  use { 'catppuccin/nvim', as = "catppuccin" }
  use 'folke/which-key.nvim'

  use { 
    "williamboman/mason.nvim",
    config = function() require('mason').setup() end
  }
  use {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
  }
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.x',
    requires = {'nvim-lua/plenary.nvim'}
  }
  use {
	"Pocco81/true-zen.nvim",
	config = function()
		 require("true-zen").setup {}
	end
  }
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
        require("trouble").setup {}
    end
  }
  vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
  require("catppuccin").setup()
  require("mason-lspconfig").setup()

  vim.cmd [[colorscheme catppuccin]]
end)


return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'tamago324/nlsp-settings.nvim'
  use 'mcchrish/zenbones.nvim'
  use 'rktjmp/lush.nvim'
  use 'glepnir/lspsaga.nvim'
  use 'ggandor/lightspeed.nvim'
  use 'ray-x/lsp_signature.nvim'
  use { 'ray-x/go.nvim', config = function() require('go').setup() end }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt=true}
  }
  use {
	  'kabouzeid/nvim-lspinstall', config = function()
		  require('lspinstall').setup()
	  end
  }
end)

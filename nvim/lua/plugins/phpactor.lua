return {
  'gbprod/phpactor.nvim',
  build = function()
    require 'phpactor.handler.update'()
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'neovim/nvim-lspconfig',
  },
  opts = {
    install = {
      path = '~/.local/share/nvim/mason/packages/phpactor',
      branch = 'master',
      bin = 'phpactor',
      php_bin = 'php',
      composer_bin = 'composer',
      git_bin = 'git',
      check_on_startup = 'none',
    },
  },
}

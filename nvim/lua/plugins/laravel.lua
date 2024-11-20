-- lua/custom/plugins/blade.lua

-- Set up filetype detection for Blade files
vim.filetype.add {
  pattern = {
    ['.*%.blade%.php'] = { 'blade', 'php' }, -- Register as both blade and php filetype
  },
}

-- Function to find Laravel project root
local function get_laravel_root(fname)
  local util = require('lspconfig').util
  return util.root_pattern(
    'artisan', -- Laravel's CLI tool
    'composer.json', -- Composer configuration
    '.git' -- Fallback to git root
  )(fname)
end

return {
  -- Mason Configuration
  {
    'williamboman/mason-lspconfig.nvim',
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      -- Only include packages that Mason actually manages
      table.insert(opts.ensure_installed, 'phpactor')
    end,
  },

  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    optional = true,
    opts = function(_, opts)
      -- Configure PHPActor
      require('lspconfig').phpactor.setup {
        init_options = {
          ['language_server_phpstan.enabled'] = false,
          ['language_server_psalm.enabled'] = false,
        },
        filetypes = { 'php', 'blade', 'blade.php' },
        root_dir = get_laravel_root,
      }

      -- Define the Blade LSP configuration
      local lspconfig = require 'lspconfig'
      local configs = require 'lspconfig.configs'

      -- Only register the blade config if it hasn't been registered yet
      if not configs.blade then
        configs.blade = {
          default_config = {
            cmd = { 'laravel-dev-generators', 'lsp' },
            filetypes = { 'blade', 'blade.php' },
            root_dir = get_laravel_root,
            settings = {},
          },
        }
      end

      -- Only set up the Blade LSP if laravel-dev-generators is installed
      if vim.fn.executable 'laravel-dev-generators' == 1 then
        lspconfig.blade.setup {}
      else
        vim.notify('laravel-dev-generators not found. Install with: npm install -g laravel-dev-generators', vim.log.levels.WARN)
      end
    end,
  },

  -- Treesitter Configuration
  {
    'nvim-treesitter/nvim-treesitter',
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'blade', 'php' })

      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = 'https://github.com/EmranMR/tree-sitter-blade',
          files = { 'src/parser.c' },
          branch = 'main',
        },
        filetype = 'blade',
      }
    end,
  },
}

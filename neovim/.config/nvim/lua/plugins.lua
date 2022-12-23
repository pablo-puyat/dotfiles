vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use "bobrown101/minimal-nnn.nvim"
    use 'terrortylor/nvim-comment'
    use 'wbthomason/packer.nvim'
    use 'folke/which-key.nvim'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'
    use 'nvim-treesitter/nvim-treesitter'
    use { 'catppuccin/nvim', as = "catppuccin" }
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.x',
        requires = {'nvim-lua/plenary.nvim'}
    }
--    use {
--        "nvim-lualine/lualine.nvim",
--        requires = "kyazdani42/nvim-web-devicons", opt = true
--    }
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                position = "right",
                icons = false,
                fold_open = "v", -- icon used for open folds
                fold_closed = ">", -- icon used for closed folds
                indent_lines = false, -- add an indent guide below the fold icons
                signs = {
                    error = "error",
                    warning = "warn",
                    hint = "hint",
                    information = "info"
                },
                use_diagnostic_signs = false
            }
        end
    }
    use {
        'samodostal/copilot-client.lua',
        requires = {
            'zbirenbaum/copilot.lua', -- requires copilot.lua and plenary.nvim
            'nvim-lua/plenary.nvim'
        },
    }



    vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
    require("nvim_comment").setup()
    require("catppuccin").setup()
    require("mason").setup()
    require("mason-lspconfig").setup()
    --require("lualine").setup()
    vim.cmd [[colorscheme catppuccin]]
    require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {}
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        ["rust_analyzer"] = function ()
            require("rust-tools").setup {}
        end
    }
end)

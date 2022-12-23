local status_ok, lualine = pcall(require, "lualine.nvim")
if not status_ok then
    return
end

local filename = {
    "filename",
    color = {},
    cond = nil,
}
local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    -- cond = conditions.hide_in_width,
}
local treesitter = {
    function()
        return "T"
    end,
    color = function()
        local buf = vim.api.nvim_get_current_buf()
        local ts = vim.treesitter.highlighter.active[buf]
        return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
    end
    -- cond = conditions.hide_in_width,
}
local lsp = {
    function(msg)
        msg = msg or "LS Inactive"
        local buf_clients = vim.lsp.buf_get_clients()
        if next(buf_clients) == nil then
            -- TODO: clean up this if statement
            if type(msg) == "boolean" or #msg == 0 then
                return "LS Inactive"
            end
            return msg
        end
        local buf_ft = vim.bo.filetype
        local buf_client_names = {}
        local copilot_active = false

        -- add client
        for _, client in pairs(buf_clients) do
            if client.name ~= "null-ls" and client.name ~= "copilot" then
                table.insert(buf_client_names, client.name)
            end

            if client.name == "copilot" then
                copilot_active = true
            end
        end

        -- add formatter
        --local formatters = require "lvim.lsp.null-ls.formatters"
        --local supported_formatters = formatters.list_registered(buf_ft)
        --vim.list_extend(buf_client_names, supported_formatters)

        -- add linter
        --local linters = require "lvim.lsp.null-ls.linters"
        --local supported_linters = linters.list_registered(buf_ft)
        --vim.list_extend(buf_client_names, supported_linters)

        local unique_client_names = vim.fn.uniq(buf_client_names)

        local language_servers = "[" .. table.concat(unique_client_names, ", ") .. "]"

        if copilot_active then
            language_servers = language_servers .. "%#SLCopilot#" .. " " .. lvim.icons.git.Octoface .. "%*"
        end

        return language_servers
    end,
    separator = separator,
    color = { gui = "bold" },
    -- cond = conditions.hide_in_width,
}
local location = { "location", color = location_color }
local progress = {
    "progress",
    fmt = function()
        return "%P/%L"
    end,
    color = {},
}

local filetype = { "filetype", cond = nil, padding = { left = 1, right = 1 } }
local setup = {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        --lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_b = {'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        --lualine_x = {},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

lualine.setup(setup)


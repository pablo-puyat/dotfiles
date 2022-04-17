local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local mode = {
	"mode",
	fmt = function(str)
		return "-- " .. str .. " --"
	end,
}

local filetype = {
	"filetype",
	icons_enabled = false,
	icon = nil,
}

local location = {
	"location",
	padding = 0,
}

-- cool function for progress
local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

local treesitter = function()
  local b = vim.api.nvim_get_current_buf()
  if next(vim.treesitter.highlighter.active[b]) then
    return "  "
  end
  return ""
end

local lsp = function()
    local buf_clients = vim.lsp.buf_get_clients()
    if next(buf_clients) == nil then
        return "LS Inactive"
    end
    local buf_client_names = {}
    for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
            table.insert(buf_client_names, client.name)
        end
    end
    return "[" .. table.concat(buf_client_names, ", ") .. "]"
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "filename" },
		lualine_b = { mode },
		lualine_c = { treesitter },
		lualine_x = { lsp, filetype },
		lualine_y = { location },
		lualine_z = { progress },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})

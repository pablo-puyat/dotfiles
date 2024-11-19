-- ~/.config/nvim/colors/monochrome.lua
local colors = {
  bg = '#1a1a1a',
  bg_dark = '#141414',
  bg_light = '#2a2a2a',
  fg = '#d4d4d4',
  fg_dark = '#a0a0a0',
  fg_light = '#ffffff',
  gray1 = '#404040',
  gray2 = '#606060',
  gray3 = '#808080',
  gray4 = '#909090',
}

-- Reset all highlighting to default
vim.cmd 'highlight clear'
if vim.fn.exists 'syntax_on' then
  vim.cmd 'syntax reset'
end

vim.g.colors_name = 'monochrome'

local highlights = {
  -- Editor
  Normal = { fg = colors.fg, bg = colors.bg },
  NormalFloat = { fg = colors.fg, bg = colors.bg_dark },
  Cursor = { fg = colors.bg, bg = colors.fg },
  CursorLine = { bg = colors.bg_light },
  LineNr = { fg = colors.gray2 },
  CursorLineNr = { fg = colors.fg_light },
  SignColumn = { bg = colors.bg },
  VertSplit = { fg = colors.gray1, bg = colors.bg },

  -- Syntax
  Comment = { fg = colors.gray3, italic = true },
  String = { fg = colors.fg_dark },
  Number = { fg = colors.fg_light },
  Identifier = { fg = colors.fg },
  Function = { fg = colors.fg_light },
  Statement = { fg = colors.fg },
  Keyword = { fg = colors.fg_light },
  Constant = { fg = colors.fg_light },
  Type = { fg = colors.fg },
  Special = { fg = colors.fg_light },

  -- Search and Selection
  Search = { fg = colors.bg, bg = colors.fg_dark },
  IncSearch = { fg = colors.bg, bg = colors.fg_light },
  Visual = { bg = colors.gray1 },

  -- Pmenu
  Pmenu = { fg = colors.fg, bg = colors.bg_dark },
  PmenuSel = { fg = colors.fg_light, bg = colors.gray1 },
  PmenuSbar = { bg = colors.bg_light },
  PmenuThumb = { bg = colors.gray2 },

  -- Status Line
  StatusLine = { fg = colors.fg, bg = colors.bg_dark },
  StatusLineNC = { fg = colors.gray3, bg = colors.bg_dark },

  -- Icon Colors (DevIcons)
  DevIconDefault = { fg = colors.fg_light },
  DevIconc = { fg = colors.fg_light },
  DevIconcss = { fg = colors.fg_light },
  DevIcondeb = { fg = colors.fg_light },
  DevIconDockerfile = { fg = colors.fg_light },
  DevIconhtml = { fg = colors.fg_light },
  DevIconjpeg = { fg = colors.fg_light },
  DevIconjpg = { fg = colors.fg_light },
  DevIconjs = { fg = colors.fg_light },
  DevIconjson = { fg = colors.fg_light },
  DevIconlua = { fg = colors.fg_light },
  DevIconmarkdown = { fg = colors.fg_light },
  DevIconpng = { fg = colors.fg_light },
  DevIconpy = { fg = colors.fg_light },
  DevIcontoml = { fg = colors.fg_light },
  DevIconts = { fg = colors.fg_light },
  DevIconttf = { fg = colors.fg_light },
  DevIconrb = { fg = colors.fg_light },
  DevIconrpm = { fg = colors.fg_light },
  DevIconrus = { fg = colors.fg_light },
  DevIconsvg = { fg = colors.fg_light },
  DevIconvim = { fg = colors.fg_light },
  DevIconyml = { fg = colors.fg_light },

  -- File Explorer
  NvimTreeNormal = { fg = colors.fg, bg = colors.bg },
  NvimTreeEndOfBuffer = { fg = colors.bg, bg = colors.bg },
  NvimTreeFolderIcon = { fg = colors.fg_light },
  NvimTreeFolderName = { fg = colors.fg },
  NvimTreeOpenedFolderName = { fg = colors.fg_light },
  NvimTreeEmptyFolderName = { fg = colors.fg_dark },
  NvimTreeFilename = { fg = colors.fg },
  NvimTreeSpecialFile = { fg = colors.fg_light },
  NvimTreeGitDirty = { fg = colors.fg_light },
  NvimTreeGitNew = { fg = colors.fg_light },
  NvimTreeGitDeleted = { fg = colors.gray3 },

  -- TreeSitter
  ['@variable'] = { fg = colors.fg },
  ['@function'] = { fg = colors.fg_light },
  ['@function.call'] = { fg = colors.fg_light },
  ['@operator'] = { fg = colors.fg },
  ['@keyword.operator'] = { fg = colors.fg_light },
  ['@constant'] = { fg = colors.fg_light },
  ['@namespace'] = { fg = colors.fg_light },
  ['@property'] = { fg = colors.fg },
  ['@field'] = { fg = colors.fg },
  ['@punctuation.delimiter'] = { fg = colors.fg },
  ['@punctuation.bracket'] = { fg = colors.fg },
  ['@punctuation.special'] = { fg = colors.fg },
  ['@string'] = { fg = colors.fg_dark },
  ['@string.regex'] = { fg = colors.fg_dark },
  ['@type'] = { fg = colors.fg },
  ['@variable.builtin'] = { fg = colors.fg_light },
  ['@text.literal'] = { fg = colors.fg },
  ['@text.reference'] = { fg = colors.fg_light },
  ['@tag'] = { fg = colors.fg_light },
  ['@tag.attribute'] = { fg = colors.fg },
  ['@tag.delimiter'] = { fg = colors.fg },
}

-- Apply highlights
for group, opts in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, opts)
end

require'plugins'
require'lspsaga'.init_lsp_saga()
require'lspconfig'.intelephense.setup{}
require'lspconfig'.vuels.setup{}

-- maps.lua
local map = vim.api.nvim_set_keymap

-- map the leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '  -- 'vim.g' sets global variables


options = { noremap = true }
map('n', '<leader><esc>', ':nohlsearch<cr>', options)
map('n', '<leader>n', ':bnext<cr>', options)
map('n', '<leader>p', ':bprev<cr>', options)
map('n', '<leader>cd', ':Lspsaga show_line_diagnostics<cr>', options)
map('n', 'gh', ':Lspsaga lsp_finder<cr>', options)
map('n', 'gd', ':Lspsaga preview_definition<cr>', options)
map('n', 'gr', ':Lspsaga rename<cr>', options)
map('n', 'gs', ':Lspsaga signature_help<cr>', options)
map('n', 'K', ':Lspsaga hover_doc<cr>', options)
map('n', 'C-f', ':Lspsaga smart_scroll_with_saga(1)<cr>', options)
map('n', 'C-b', ':Lspsaga smart_scroll_with_saga(-1)<cr>', options)
map('n', '[e', ':Lspsaga diagnostic_jump_next<cr>', options)
map('n', ']e', ':Lspsaga diagnostic_jump_prev<cr>', options)

vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()
augroup END
]],
  true
)

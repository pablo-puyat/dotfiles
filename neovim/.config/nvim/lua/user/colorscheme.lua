vim.cmd [[
try
  colorscheme kanagawa
  highlight Normal ctermbg=none guibg=none
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]

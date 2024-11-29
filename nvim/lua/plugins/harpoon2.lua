return  {
  "theprimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("harpoon"):setup()
  end,
  keys = {
    { "<leader>hh", function() require("harpoon"):list():append() end, desc = "harpoon file", },
    { "<leader>hm", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "harpoon quick menu", },
    { "<leader>h1", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
    { "<leader>h2", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
    { "<leader>h3", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
    { "<leader>h4", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
    { "<leader>h5", function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5", },
  },
}

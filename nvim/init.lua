-- ============================================================
-- SECTION 1: FOUNDATION
-- Core Neovim settings, leaders, options, basic keymaps, basic autocmds
-- ============================================================
do
  -- Enable faster startup by caching compiled Lua modules
  vim.loader.enable()

  -- Set <space> as the leader key
  -- See `:help mapleader`
  --  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- Set to true if you have a Nerd Font installed and selected in the terminal
  vim.g.have_nerd_font = true

  -- [[ Setting options ]]
  --  See `:help vim.o`
  -- NOTE: You can change these options as you wish!
  --  For more options, you can see `:help option-list`

  vim.o.number = false

  -- Enable mouse mode, can be useful for resizing splits for example!
  vim.o.mouse = 'a'

  -- Don't show the mode, since it's already in the status line
  vim.o.showmode = false

  -- Sync clipboard between OS and Neovim.
  --  Schedule the setting after `UiEnter` because it can increase startup-time.
  --  Remove this option if you want your OS clipboard to remain independent.
  --  See `:help 'clipboard'`
  vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

  -- Enable break indent
  vim.o.breakindent = true

  -- Enable undo/redo changes even after closing and reopening a file
  vim.o.undofile = true

  -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Keep signcolumn on by default
  vim.o.signcolumn = 'yes'

  -- Decrease update time
  vim.o.updatetime = 250

  -- Decrease mapped sequence wait time
  vim.o.timeoutlen = 300

  -- Configure how new splits should be opened
  vim.o.splitright = true
  vim.o.splitbelow = true

  vim.o.list = false
  vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

  -- Preview substitutions live, as you type!
  vim.o.inccommand = 'split'

  -- Show which line your cursor is on
  vim.o.cursorline = true

  -- Minimal number of screen lines to keep above and below the cursor.
  vim.o.scrolloff = 10

  -- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
  -- instead raise a dialog asking if you wish to save the current file(s)
  -- See `:help 'confirm'`
  vim.o.confirm = true

  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  -- [[ Basic Keymaps ]]
  --  See `:help vim.keymap.set()`

  -- Clear highlights on search when pressing <Esc> in normal mode
  --  See `:help hlsearch`
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Diagnostic Config & Keymaps
  --  See `:help vim.diagnostic.Opts`
  vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    virtual_text = false, -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
  }

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- Keybinds to make split navigation easier.
  --  Use CTRL+<hjkl> to switch between windows
  --
  --  See `:help wincmd` for a list of all window commands
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  -- [[ Basic Autocommands ]]
  --  See `:help lua-guide-autocommands`

  -- Highlight when yanking (copying) text
  --  Try it with `yap` in normal mode
  --  See `:help vim.hl.on_yank()`
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
  })
end

-- ============================================================
-- SECTION 2: PLUGIN MANAGER INTRO
-- vim.pack intro, build hooks
-- ============================================================
do
  local function run_build(name, cmd, cwd)
    local result = vim.system(cmd, { cwd = cwd }):wait()
    if result.code ~= 0 then
      local stderr = result.stderr or ''
      local stdout = result.stdout or ''
      local output = stderr ~= '' and stderr or stdout
      if output == '' then output = 'No output from build command.' end
      vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
    end
  end

  -- This autocommand runs after a plugin is installed or updated and
  --  runs the appropriate build command for that plugin if necessary.
  --
  -- See `:help vim.pack-events`
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      local name = ev.data.spec.name
      local kind = ev.data.kind
      if kind ~= 'install' and kind ~= 'update' then return end

      if name == 'LuaSnip' then
        if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then run_build(name, { 'make', 'install_jsregexp' }, ev.data.path) end
        return
      end

      if name == 'nvim-treesitter' then
        if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
        vim.cmd 'TSUpdate'
        return
      end
    end,
  })
end

---Because most plugins are hosted on GitHub, you can use the helper
---function to have less repetition in the following sections.
---@param repo string
---@return string
local function gh(repo) return 'https://github.com/' .. repo end

-- ============================================================
-- SECTION 3: UI / CORE UX PLUGINS
-- guess-indent, gitsigns, which-key, colorscheme, todo-comments, mini modules
-- ============================================================
do
  -- [[ Installing and Configuring Plugins ]]
  vim.pack.add { gh 'folke/snacks.nvim' }

  -- Quick Access (Muscle Memory / Punctuation)
  vim.keymap.set('n', '<leader><leader>', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
  vim.keymap.set('n', '<leader>/', function() Snacks.picker.grep() end, { desc = 'Grep' })
  vim.keymap.set('n', '<leader>:', function() Snacks.picker.command_history() end, { desc = 'Command History' })

  -- [B]uffers
  vim.keymap.set('n', '<leader>bb', function() Snacks.picker.buffers() end, { desc = 'Find [B]uffers' })
  vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = '[D]elete Buffer' })
  vim.keymap.set('n', '<leader>bs', function() Snacks.scratch() end, { desc = 'Toggle [S]cratch Buffer' })
  vim.keymap.set('n', '<leader>bS', function() Snacks.scratch.select() end, { desc = 'Select [S]cratch Buffer' })

  -- [F]iles & Finding
  vim.keymap.set('n', '<leader>fc', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, { desc = 'Find [C]onfig File' })
  vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files() end, { desc = 'Find [F]iles' })
  vim.keymap.set('n', '<leader>fg', function() Snacks.picker.git_files() end, { desc = 'Find [G]it Files' })
  vim.keymap.set('n', '<leader>fp', function() Snacks.picker.projects() end, { desc = 'Find [P]rojects' })
  vim.keymap.set('n', '<leader>fr', function() Snacks.picker.recent() end, { desc = 'Find [R]ecent' })
  vim.keymap.set('n', '<leader>fR', function() Snacks.rename.rename_file() end, { desc = '[R]ename File' })

  -- [G]it & GitHub
  vim.keymap.set('n', '<leader>gb', function() Snacks.picker.git_branches() end, { desc = 'Git [B]ranches' })
  vim.keymap.set('n', '<leader>gl', function() Snacks.picker.git_log() end, { desc = 'Git [L]og' })
  vim.keymap.set('n', '<leader>gL', function() Snacks.picker.git_log_line() end, { desc = 'Git [L]og Line' })
  vim.keymap.set('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = 'Git [S]tatus' })
  vim.keymap.set('n', '<leader>gS', function() Snacks.picker.git_stash() end, { desc = 'Git [S]tash' })
  vim.keymap.set('n', '<leader>gd', function() Snacks.picker.git_diff() end, { desc = 'Git [D]iff (Hunks)' })
  vim.keymap.set('n', '<leader>gf', function() Snacks.picker.git_log_file() end, { desc = 'Git Log [F]ile' })
  vim.keymap.set('n', '<leader>gi', function() Snacks.picker.gh_issue() end, { desc = 'GitHub [I]ssues (open)' })
  vim.keymap.set('n', '<leader>gI', function() Snacks.picker.gh_issue { state = 'all' } end, { desc = 'GitHub [I]ssues (all)' })
  vim.keymap.set('n', '<leader>gp', function() Snacks.picker.gh_pr() end, { desc = 'GitHub [P]ull Requests (open)' })
  vim.keymap.set('n', '<leader>gP', function() Snacks.picker.gh_pr { state = 'all' } end, { desc = 'GitHub [P]ull Requests (all)' })
  vim.keymap.set({ 'n', 'v' }, '<leader>gB', function() Snacks.gitbrowse() end, { desc = 'Git [B]rowse' })
  vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'Lazy[g]it' })

  -- [N]otifications
  vim.keymap.set('n', '<leader>nn', function() Snacks.picker.notifications() end, { desc = '[N]otification History' })
  vim.keymap.set('n', '<leader>nd', function() Snacks.notifier.hide() end, { desc = '[D]ismiss All Notifications' })

  -- [S]earch (Snacks Pickers)
  vim.keymap.set('n', '<leader>sb', function() Snacks.picker.lines() end, { desc = 'Search [B]uffer Lines' })
  vim.keymap.set('n', '<leader>sB', function() Snacks.picker.grep_buffers() end, { desc = 'Search Open [B]uffers (Grep)' })
  vim.keymap.set('n', '<leader>sg', function() Snacks.picker.grep() end, { desc = 'Search [G]rep' })
  vim.keymap.set({ 'n', 'x' }, '<leader>sw', function() Snacks.picker.grep_word() end, { desc = 'Search [W]ord (or selection)' })
  vim.keymap.set('n', '<leader>s"', function() Snacks.picker.registers() end, { desc = 'Search Registers' })
  vim.keymap.set('n', '<leader>s/', function() Snacks.picker.search_history() end, { desc = 'Search History' })
  vim.keymap.set('n', '<leader>sa', function() Snacks.picker.autocmds() end, { desc = 'Search [A]utocmds' })
  vim.keymap.set('n', '<leader>sc', function() Snacks.picker.command_history() end, { desc = 'Search [C]ommand History' })
  vim.keymap.set('n', '<leader>sC', function() Snacks.picker.commands() end, { desc = 'Search [C]ommands' })
  vim.keymap.set('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = 'Search [D]iagnostics' })
  vim.keymap.set('n', '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, { desc = 'Search Buffer [D]iagnostics' })
  vim.keymap.set('n', '<leader>sh', function() Snacks.picker.help() end, { desc = 'Search [H]elp Pages' })
  vim.keymap.set('n', '<leader>sH', function() Snacks.picker.highlights() end, { desc = 'Search [H]ighlights' })
  vim.keymap.set('n', '<leader>si', function() Snacks.picker.icons() end, { desc = 'Search [I]cons' })
  vim.keymap.set('n', '<leader>sj', function() Snacks.picker.jumps() end, { desc = 'Search [J]umps' })
  vim.keymap.set('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = 'Search [K]eymaps' })
  vim.keymap.set('n', '<leader>sl', function() Snacks.picker.loclist() end, { desc = 'Search [L]ocation List' })
  vim.keymap.set('n', '<leader>sm', function() Snacks.picker.marks() end, { desc = 'Search [M]arks' })
  vim.keymap.set('n', '<leader>sM', function() Snacks.picker.man() end, { desc = 'Search [M]an Pages' })
  vim.keymap.set('n', '<leader>sp', function() Snacks.picker.lazy() end, { desc = 'Search [P]lugin Spec (Lazy)' })
  vim.keymap.set('n', '<leader>sq', function() Snacks.picker.qflist() end, { desc = 'Search [Q]uickfix List' })
  vim.keymap.set('n', '<leader>sR', function() Snacks.picker.resume() end, { desc = 'Search [R]esume' })
  vim.keymap.set('n', '<leader>su', function() Snacks.picker.undo() end, { desc = 'Search [U]ndo History' })

  -- [U]I / Appearance
  vim.keymap.set('n', '<leader>uc', function() Snacks.picker.colorschemes() end, { desc = '[C]olorschemes' })
  vim.keymap.set('n', '<leader>uz', function() Snacks.zen() end, { desc = 'Toggle [Z]en Mode' })
  vim.keymap.set('n', '<leader>uZ', function() Snacks.zen.zoom() end, { desc = 'Toggle [Z]oom' })
  vim.keymap.set('n', '<c-/>', function() Snacks.terminal() end, { desc = 'Toggle Terminal' })
  vim.keymap.set('n', '<c-_>', function() Snacks.terminal() end, { desc = 'which_key_ignore' })
  vim.keymap.set('n', '<leader>un', '<CMD> Gitsigns toggle_signs<CR>', {desc = 'toggle gitsigns'}) 
  -- Top-level / Misc Toggles
  --vim.keymap.set('n', '<leader>e', function() Snacks.explorer() end, { desc = 'File [E]xplorer' })
  vim.keymap.set({ 'n', 't' }, ']]', function() Snacks.words.jump(vim.v.count1) end, { desc = 'Next Reference' })
  vim.keymap.set({ 'n', 't' }, '[[', function() Snacks.words.jump(-vim.v.count1) end, { desc = 'Prev Reference' })

  -- LSP (Snacks Picker Overrides)
  vim.keymap.set('n', 'gd', function() Snacks.picker.lsp_definitions() end, { desc = 'Goto Definition' })
  vim.keymap.set('n', 'gD', function() Snacks.picker.lsp_declarations() end, { desc = 'Goto Declaration' })
  vim.keymap.set('n', 'gr', function() Snacks.picker.lsp_references() end, { nowait = true, desc = 'References' })
  vim.keymap.set('n', 'gI', function() Snacks.picker.lsp_implementations() end, { desc = 'Goto Implementation' })
  vim.keymap.set('n', 'gy', function() Snacks.picker.lsp_type_definitions() end, { desc = 'Goto T[y]pe Definition' })
  vim.keymap.set('n', 'gai', function() Snacks.picker.lsp_incoming_calls() end, { desc = 'C[a]lls Incoming' })
  vim.keymap.set('n', 'gao', function() Snacks.picker.lsp_outgoing_calls() end, { desc = 'C[a]lls Outgoing' })
  vim.keymap.set('n', '<leader>ss', function() Snacks.picker.lsp_symbols() end, { desc = 'LSP Symbols' })
  vim.keymap.set('n', '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, { desc = 'LSP Workspace Symbols' })

  require('snacks').setup {}

  vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
  require('guess-indent').setup {}

  if vim.g.have_nerd_font then vim.pack.add { gh 'nvim-tree/nvim-web-devicons' } end

  vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
  require('gitsigns').setup {
    signcolumn = false,
    signs = {
      add = { text = '+' }, ---@diagnostic disable-line: missing-fields
      change = { text = '~' }, ---@diagnostic disable-line: missing-fields
      delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
      topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
      changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
    },
  }

  vim.pack.add { gh 'folke/which-key.nvim' }
  require('which-key').setup {
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },
    spec = {
      { '<leader>b', group = '[B]uffer' },
      { '<leader>f', group = '[F]ile' },
      { '<leader>g', group = '[G]it' },
      { '<leader>n', group = '[N]otifications' },
      { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>u', group = '[U]I' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      { 'gr', group = 'LSP Actions', mode = { 'n' } },
    },
  }

  -- [[ Colorscheme ]]
  vim.pack.add { { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' } }

  vim.pack.add { gh 'folke/todo-comments.nvim' }
  require('todo-comments').setup { signs = false }

  vim.pack.add { gh 'nvim-mini/mini.nvim' }

  require('mini.ai').setup {
    mappings = {
      around_next = 'aa',
      inside_next = 'ii',
    },
    n_lines = 500,
  }

  require('mini.surround').setup()

  local statusline = require 'mini.statusline'
  statusline.setup { 
    use_icons = vim.g.have_nerd_font,
    content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      --local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
      local filename = MiniStatusline.section_filename({ trunc_width = 140 })
      local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local location = MiniStatusline.section_location({ trunc_width = 75 })
      local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

      return MiniStatusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        -- { hl = 'MiniStatuslineDevinfo', strings = { lsp } },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- End left alignment
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl, strings = { search, location } },
      })
    end,
  }
  }
  ---@diagnostic disable-next-line: duplicate-set-field
  -- statusline.section_location = function() return '%2l:%-2v' end
end

-- ============================================================
-- SECTION 4: LSP
-- LSP keymaps, server configuration, Mason tools installations
-- ============================================================
do
  vim.pack.add { gh 'j-hui/fidget.nvim' }
  require('fidget').setup {}

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map('<leader>cr', vim.lsp.buf.rename, '[C]ode Re[n]ame')
      map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
      map('<leader>cd', vim.lsp.buf.declaration, '[C]ode [D]eclaration')
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client:supports_method('textDocument/documentHighlight', event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      if client and client:supports_method('textDocument/inlayHint', event.buf) then
        map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
      end
    end,
  })

  ---@type table<string, vim.lsp.Config>
  local servers = {
    gopls = {},
    ts_ls = {},
    svelte = {},
    tailwindcss = {},
    intelephense = {},
    stylua = {},

    lua_ls = {
      on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false

        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = { 'lua/?.lua', 'lua/?/init.lua' },
          },
          workspace = {
            checkThirdParty = false,
            library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
              '${3rd}/luv/library',
              '${3rd}/busted/library',
            }),
          },
        })
      end,
      ---@type lspconfig.settings.lua_ls
      settings = {
        Lua = {
          format = { enable = false },
        },
      },
    },
  }

  vim.pack.add {
    gh 'neovim/nvim-lspconfig',
    gh 'mason-org/mason.nvim',
    gh 'mason-org/mason-lspconfig.nvim',
    gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  }

  require('mason').setup {}

  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {})

  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
  end
end

-- ============================================================
-- SECTION 5: FORMATTING
-- conform.nvim setup and keymap
-- ============================================================
do
  vim.pack.add { gh 'stevearc/conform.nvim' }
  require('conform').setup {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local enabled_filetypes = {}
      if enabled_filetypes[vim.bo[bufnr].filetype] then
        return { timeout_ms = 500 }
      else
        return nil
      end
    end,
    default_format_opts = {
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
    },
  }

  vim.keymap.set({ 'n', 'v' }, '<leader>cf', function() require('conform').format { async = true } end, { desc = '[C]ode [F]ormat buffer' })
end

-- ============================================================
-- SECTION 6: AUTOCOMPLETE & SNIPPETS
-- blink.cmp and luasnip setup
-- ============================================================
do
  vim.pack.add { { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
  require('luasnip').setup {}

  vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
  require('blink.cmp').setup {
    keymap = {
      preset = 'default',
    },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets' },
    },

    snippets = { preset = 'luasnip' },

    fuzzy = { implementation = 'lua' },

    signature = { enabled = true },
  }
end

-- ============================================================
-- SECTION 7: TREESITTER
-- Parser installation, syntax highlighting, folds, indentation
-- ============================================================
do
  vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }

  local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
  require('nvim-treesitter').install(parsers)

  ---@param buf integer
  ---@param language string
  local function treesitter_try_attach(buf, language)
    if not vim.treesitter.language.add(language) then return end
    vim.treesitter.start(buf, language)

    local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

    if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
  end

  local available_parsers = require('nvim-treesitter').get_available()
  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local buf, filetype = args.buf, args.match

      local language = vim.treesitter.language.get_lang(filetype)
      if not language then return end

      local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

      if vim.tbl_contains(installed_parsers, language) then
        treesitter_try_attach(buf, language)
      elseif vim.tbl_contains(available_parsers, language) then
        require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
      else
        treesitter_try_attach(buf, language)
      end
    end,
  })
end

vim.pack.add {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

vim.keymap.set('n', '\\', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })

require('neo-tree').setup {
  filesystem = {
    window = {
      mappings = {
        ['\\'] = 'close_window',
      },
    },
  },
}

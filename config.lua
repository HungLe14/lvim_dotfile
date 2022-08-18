--[[
lvim is the global options object Linters should be filled in as strings with either a global executable or a path to
an executable ]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
-- Personal setting dashboard
require "user.alpha" -- general lvim.log.level = "warn" vim.opt.relativenumber = true
vim.opt.wrap = true
vim.lsp.buf.format({ timeout_ms = 2000 })
vim.o.guifont = "Hack Nerd Font"
-- show diagnostic in a float window in menu <leader>lD
lvim.builtin.which_key.mappings["lD"] = {
  "<cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostic float"
}

lvim.builtin.which_key.mappings["gS"] = { "<cmd>Telescope git_stash<CR>", "Stash List", }

lvim.builtin.which_key.mappings["F"] = { "<cmd>Telescope file_browser<CR>", "Find Folder", }

lvim.builtin.which_key.mappings["W"] = { "<cmd>:lua require('nvim-window').pick()<CR>", "Window", }

lvim.builtin.which_key.mappings["o"] = {
  name = "Others",
  s = { "<cmd>SymbolsOutline<cr>", "Symbols Outline" },
  a = { "<cmd>CopyAbsolutePath<CR>", "Copy Absolute Path" }, r = { "<cmd>CopyRelPath<CR>", "Copy Relative Path" },
  n = { "<cmd>NvimTreeRefresh<CR>", "Refresh NvimTree" },
  b = { "<cmd>e<CR>", "Refresh Buffer" },
  p = { "<cmd>:Telescope projects<CR>", "Open Project" }
}

lvim.builtin.which_key.mappings["ge"] = {
  name = "Git Conflict",
  l = { "<cmd>GitConflictListQf<cr>", "List all conflict" },
  c = { "<cmd>GitConflictChooseOurs<CR>", "Select current changes" },
  i = { "<cmd>GitConflictChooseTheirs<CR>", "Select incoming changes" },
  b = { "<cmd>GitConflictChooseBoth<CR>", "Select both changes" },
  n = { "<cmd>GitConflictChooseNone<CR>", "Select none changes" },
  N = { "<cmd>GitConflictNextConflict<CR>", "Move to next conflict" },
  P = { "<cmd>GitConflictPrevConflict<CR>", "Move to previous conflict" },
}

lvim.builtin.which_key.mappings["t"] = {
  name = "Toggle Terminal",
  v = { "<cmd>ToggleTerm direction=vertical<cr>", "Toggle Terminal Vertical" },
  h = { "<cmd>ToggleTerm direction=horizontal<cr>", "Toggle Terminal Horizontal" },
}

-- Function using to copy file path
vim.api.nvim_create_user_command("CopyAbsolutePath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
vim.api.nvim_create_user_command("CopyRelPath",
  function()

    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", vim.fn.fnamemodify(path, ":."))
    -- vim.api.nvim_call_function("setreg", { "+", vim.fn.fnamemodify(vim.fn.expand("%"), ":.") })
    vim.notify('Copied "' .. vim.fn.fnamemodify(path, ":.") .. '" to the clipboard!')
  end, {})

-- format on save
lvim.format_on_save = {
  pattern = "*",
  timeout = 2000,
}

-- colorscheme
-- lvim.colorscheme = "dracula"
-- lvim.colorscheme = "tokyonight"
-- lvim.colorscheme = "nightfox"
lvim.colorscheme = "catppuccin"
vim.g.catppuccin_flavour = "macchiato"

-- set rainbow parentheses
lvim.builtin.treesitter.rainbow.enable = false

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
lvim.keys.normal_mode["<C-q>"] = ":q!<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )
-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "html",
  "ruby",
  "dockerfile",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
lvim.lsp.automatic_servers_installation = true

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- linter and formatter for ruby
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "solargraph" })
require("lspconfig").solargraph.setup({})
local null_ls = require("null-ls")
local sources = {
  null_ls.builtins.diagnostics.rubocop,
}
null_ls.register({ sources = sources })

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  --   { command = "black", filetypes = { "python" } },
  --   { command = "isort", filetypes = { "python" } },
  --   {
  --     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --     command = "prettier",
  --     ---@usage arguments to pass to the formatter
  --     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --     extra_args = { "--print-with", "100" },
  --     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --     filetypes = { "typescript", "typescriptreact" },
  --   },
  {
    command = "prettierd",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "css", "scss", "html", "json", "yaml" },
  }
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  -- { command = "flake8", filetypes = { "python" } },
  --   {
  --     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --     command = "shellcheck",
  --     ---@usage arguments to pass to the formatter
  --     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --     extra_args = { "--severity", "warning" },
  --   },
  --   {
  --     command = "codespell",
  --     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --     filetypes = { "javascript", "python" },
  --   },
  {
    command = "eslint_d",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
  }
}

-- -- set additional code actions
local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    command = "eslint_d",
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
  }
}

-- Additional Plugins
lvim.plugins = {
  { "folke/tokyonight.nvim" },
  { "EdenEast/nightfox.nvim" },
  { "dracula/vim" },
  { "catppuccin/nvim" },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end,
  },
  {
    "p00f/nvim-ts-rainbow",
  }, {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript", "javascriptreact", "typescript",
        "typescriptreact" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
      })
    end
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require "lsp_signature".on_attach() end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    setup = function()
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char = "▏"
      vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
      vim.g.indent_blankline_buftype_exclude = { "terminal" }
      vim.g.indent_blankline_show_trailing_blankline_indent = true
      vim.g.indent_blankline_show_first_indent_level = true
      vim.g.indent_blankline_show_current_context = true
      vim.g.indent_blankline_show_current_context_start = true
    end
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  { 'akinsho/git-conflict.nvim', tag = "*", config = function()
    require('git-conflict').setup({
      {
        default_mappings = false, -- disable buffer local mapping created by this plugin
        disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
        highlights = { -- They must have background color, otherwise the default color will be used
          incoming = 'DiffText',
          current = 'DiffAdd',
        }
      }
    })
  end },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
  }, {
    "nvim-telescope/telescope-file-browser.nvim"
  }, {
    "tpope/vim-surround",
    -- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
    setup = function()
      vim.o.timeoutlen = 500
    end
  },
  {
    "https://gitlab.com/yorickpeterse/nvim-window.git"
  },
}

-- config window picker
require('nvim-window').setup({
  normal_hl = 'Normal',
  hint_hl = 'Bold',
  border = 'single'
})

-- add file_browser to telescope
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "file_browser")
  -- any other extensions loading
end

-- override file_browser of telescope project
local file_browser = require('telescope').load_extension('file_browser')
require('telescope.builtin').file_browser = file_browser.file_browser

-- config lualine
local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.options.globalstatus = false
lvim.builtin.lualine.options.theme = "palenight"
lvim.builtin.lualine.options.component_separators = { left = '', right = '' }
lvim.builtin.lualine.options.section_separators = { left = '', right = '' }
lvim.builtin.lualine.sections.lualine_a = { { "mode", padding = 2 } }
lvim.builtin.lualine.sections.lualine_b = { { "branch", 'diff', padding = 2 } }
lvim.builtin.lualine.sections.lualine_c = { { "filename", padding = 2 } }
lvim.builtin.lualine.sections.lualine_x = { 'diagnostics', components.lsp, 'filetype' }
lvim.builtin.lualine.sections.lualine_y = { { "progress", padding = 1 } }
lvim.builtin.lualine.sections.lualine_z = { { "location", padding = 1 } }

-- config SymbolsOutline
vim.g.symbols_outline = {
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = true,
  position = 'right',
  relative_width = true,
  width = 25,
  auto_close = false,
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  preview_bg_highlight = 'Pmenu',
  keymaps = { -- These keymaps can be a string or a table for multiple keys
    close = { "<Esc>", "q" },
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    toggle_preview = "K",
    rename_symbol = "r",
    code_actions = "a",
  },
  lsp_blacklist = {},
  symbol_blacklist = {},
  symbols = {
    File = { icon = "", hl = "TSURI" },
    Module = { icon = "", hl = "TSNamespace" },
    Namespace = { icon = "", hl = "TSNamespace" },
    Package = { icon = "", hl = "TSNamespace" },
    Class = { icon = "𝓒", hl = "TSType" },
    Method = { icon = "ƒ", hl = "TSMethod" },
    Property = { icon = "", hl = "TSMethod" },
    Field = { icon = "", hl = "TSField" },
    Constructor = { icon = "", hl = "TSConstructor" },
    Enum = { icon = "ℰ", hl = "TSType" },
    Interface = { icon = "ﰮ", hl = "TSType" },
    Function = { icon = "", hl = "TSFunction" },
    Variable = { icon = "", hl = "TSConstant" },
    Constant = { icon = "", hl = "TSConstant" },
    String = { icon = "𝓐", hl = "TSString" },
    Number = { icon = "#", hl = "TSNumber" },
    Boolean = { icon = "⊨", hl = "TSBoolean" },
    Array = { icon = "", hl = "TSConstant" },
    Object = { icon = "⦿", hl = "TSType" },
    Key = { icon = "🔐", hl = "TSType" },
    Null = { icon = "NULL", hl = "TSType" },
    EnumMember = { icon = "", hl = "TSField" },
    Struct = { icon = "𝓢", hl = "TSType" },
    Event = { icon = "🗲", hl = "TSType" },
    Operator = { icon = "+", hl = "TSOperator" },
    TypeParameter = { icon = "𝙏", hl = "TSParameter" }
  }
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
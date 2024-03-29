-- originally authored by @AdamWhittingham

local path_ok, plenary_path = pcall(require, "plenary.path")
if not path_ok then
  return
end

local dashboard = require "alpha.themes.dashboard"
local user_config_path = require("lvim.config"):get_user_config_path()
local cdir = vim.fn.getcwd()
local if_nil = vim.F.if_nil

local function get_extension(fn)
  local match = fn:match "^.+(%..+)$"
  local ext = ""
  if match ~= nil then
    ext = match:sub(2)
  end
  return ext
end

local function icon(fn)
  local nwd = require "nvim-web-devicons"
  local ext = get_extension(fn)
  return nwd.get_icon(fn, ext, { default = true })
end

local function file_button(fn, sc, short_fn)
  short_fn = short_fn or fn
  local ico_txt
  local fb_hl = {}

  if lvim.use_icons then
    local ico, hl = icon(fn)
    table.insert(fb_hl, { hl, 0, 3 })
    ico_txt = ico .. "  "
  else
    ico_txt = ""
  end
  local file_button_el = dashboard.button(sc, ico_txt .. short_fn, "<cmd>e " .. fn .. " <CR>")
  local fn_start = short_fn:match ".*[/\\]"
  if fn_start ~= nil then
    table.insert(fb_hl, { "Comment", #ico_txt - 2, #fn_start + #ico_txt })
  end
  file_button_el.opts.hl = fb_hl
  return file_button_el
end

local default_mru_ignore = { "gitcommit" }

local mru_opts = {
  ignore = function(path, ext)
    return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
  end,
}

--- @param start number
--- @param cwd string optional
--- @param items_number number optional number of items to generate, default = 10
local function mru(start, cwd, items_number, opts)
  opts = opts or mru_opts
  items_number = if_nil(items_number, 5)

  local oldfiles = {}
  for _, v in pairs(vim.v.oldfiles) do
    if #oldfiles == items_number then
      break
    end
    local cwd_cond
    if not cwd then
      cwd_cond = true
    else
      cwd_cond = vim.startswith(v, cwd)
    end
    local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
    if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
      oldfiles[#oldfiles + 1] = v
    end
  end
  local target_width = 35

  local tbl = {}
  for i, fn in ipairs(oldfiles) do
    local short_fn
    if cwd then
      short_fn = vim.fn.fnamemodify(fn, ":.")
    else
      short_fn = vim.fn.fnamemodify(fn, ":~")
    end

    if #short_fn > target_width then
      short_fn = plenary_path.new(short_fn):shorten(1, { -2, -1 })
      if #short_fn > target_width then
        short_fn = plenary_path.new(short_fn):shorten(1, { -1 })
      end
    end

    local shortcut = tostring(i + start - 1)

    local file_button_el = file_button(fn, shortcut, short_fn)
    tbl[i] = file_button_el
  end
  return {
    type = "group",
    val = tbl,
    opts = { spacing = 1 },
  }
end

local default_header = {
  type = "text",
  val = {
    [[]],
    [[]],
    [[]],
    [[]],
    [[]],
    [[]],
    [[██╗     ██╗    ██╗   ██╗ ██████╗ ███╗   ██╗ ██████╗      ██╗  ██╗██╗███╗   ██╗ ██████╗ ]],
    [[██║     ██║    ╚██╗ ██╔╝██╔═══██╗████╗  ██║██╔════╝      ╚██╗██╔╝██║████╗  ██║██╔════╝ ]],
    [[██║     ██║     ╚████╔╝ ██║   ██║██╔██╗ ██║██║  ███╗      ╚███╔╝ ██║██╔██╗ ██║██║  ███╗]],
    [[██║     ██║      ╚██╔╝  ██║   ██║██║╚██╗██║██║   ██║      ██╔██╗ ██║██║╚██╗██║██║   ██║]],
    [[███████╗██║       ██║   ╚██████╔╝██║ ╚████║╚██████╔╝     ██╔╝ ██╗██║██║ ╚████║╚██████╔╝]],
    [[╚══════╝╚═╝       ╚═╝    ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝      ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ]],
    [[]],
    [[]],
    [[]],
    [[]],
    [[]],
    [[]],
    [[]],
  },
  opts = {
    position = "center",
    hl = "Label",
    -- wrap = "overflow";
  },
}

local section_mru = {
  type = "group",
  val = {
    {
      type = "text",
      val = "Recent files",
      opts = {
        hl = "SpecialComment",
        shrink_margin = false,
        position = "center",
      },
    },
    { type = "padding", val = 1 },
    {
      type = "group",
      val = function()
        return { mru(0, cdir) }
      end,
      opts = { shrink_margin = false },
    },
  },
}

local buttons = {
  type = "group",
  val = {
    dashboard.button("SPC f", "󰈞  Find File", ":Telescope find_files<CR>"),
    dashboard.button("SPC n", "󰈔  New File", ":ene!<CR>"),
    dashboard.button("SPC P", "󰄉  Recent Projects ", ":Telescope projects<CR>"),
    dashboard.button("SPC s r", "  Recently Used Files", ":Telescope oldfiles<CR>"),
    dashboard.button("SPC s t", "󰊄  Find Word", ":Telescope live_grep<CR>"),
    dashboard.button("SPC P u", "󰃘  Update Package", ":Lazy<CR>"),
    dashboard.button("SPC L u", "󰚰  Update Lvim", ":LvimUpdate<CR>"),
    dashboard.button("SPC L c", "  Configuration", ":edit " .. user_config_path .. "<CR>"),
  },
  position = "center",
  opts = {
    spacing = 1,
  }
}

lvim.builtin.alpha.dashboard.config = {
  layout = {
    { type = "padding", val = 2 },
    default_header,
    { type = "padding", val = 2 },
    section_mru,
    { type = "padding", val = 2 },
    buttons,
  },
  opts = {
    margin = 5,
    setup = function()
      vim.cmd [[autocmd alpha_temp DirChanged * lua require('alpha').redraw()]]
    end,
  },
}

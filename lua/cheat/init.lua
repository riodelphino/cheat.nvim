-- print("init.lua top")

local M = {}

vim.g.loaded_cheat = true

-- Require
fn = require("cheat.functions")

-- Default configuration
local default_configs = {
   debug = true,
   window = {
      default_style = "float",     -- (Unimplemented) "vsplit", "hsplit"
      vsplit = { height = { size = 20 } },
      hsplit = { width = { size = 40 } },
      float = {
         width = {
            ratio = 0.8,
         },
         height = {
            ratio = 0.9,
         },
         signcolumn = false,
      },
   },
   file = {
      dir = "~/.config/nvim/cheat",
      prefix = "cheat-",
      ext = ".md",
   },
   keymaps = {
      ["<leader>ch"] = ":Cheat",
      ["<leader>cn"] = ":Cheat nvim",
      ["<leader>ct"] = ":Cheat tmux",
   },
   cheatsheets = {
      filetypes = {
         lua = { "*.lua" },
         vim = { "*.vim", "*.vifmrc" },
         js = { "*.js", "*.mjs" },
         css = { "*.css", "*.scss", "*.sass" },
         md = { "*.md" },
         php = { "*.php" },
         html = { "*.html" },
      },
   },
}

local configs = default_configs

local function update_configs(configs, user_configs)
   for k, v in pairs(user_configs) do
      if type(v) == "table" then
         if not configs[k] then configs[k] = {} end
         update_configs(configs[k], v)
      else
         configs[k] = v
      end
   end
end

function M.setup(user_configs)
   --
   update_configs(configs, user_configs)
   -- fn.print_table(configs, configs.debug)
   -- fn.print_table(user_configs, configs.debug)
   defineKeymaps()
   defineCommands()
end

function M.toggle_cheat_sheet(cheat_name)
   local path
   if vim.b.cheatbuf ~= nil then   -- Close existing cheatsheet
      M.close_cheat_sheet(vim.b.cheatbuf)
      vim.b.cheatbuf = nil
   else                                                 -- Open cheatsheet
      fn.print("cheat_name: " .. tostring(cheat_name))
      if cheat_name == "" or cheat_name == nil then     -- If no cheat_name was set, show cheat by filetypes.
         local filename = vim.fn.bufname("%")
         cheat_name = M.getCheatName(filename)
         path = M.getCheatPath(cheat_name)
      else     -- If cheat_name was set.
         path = M.getCheatPath(cheat_name)
      end
      fn.print("path: " .. tostring(path))
      local type = configs.window.type
      if type == "vsplit" or type == "hsplit" then
         vim.b.cheatbuf = M.open_cheat_sheet(path)
      elseif type == "float" then
         vim.b.cheatbuf = M.open_cheat_sheet_float(path)
      end
   end
end

function M.open_cheat_sheet(path)
   -- local path = vim.fn.expand(configs.cheat_file)

   if not vim.fn.filereadable(path) then
      print("not exists.")
      return
   end

   local split_command
   local type = configs.window.type
   if type == "vsplit" then
      split_command = ":vs"
   elseif type == "hsplit" then
      split_command = ":sp"
   end
   vim.cmd(split_command)
   vim.cmd("view " .. path)
   fn.print("vim.fn.bufnr('%'): " .. tostring(vim.fn.bufnr("%")), configs.debug)
   buf = vim.fn.bufnr("%")
   return buf
end

function M.open_cheat_sheet_float(path)
   local buf = vim.api.nvim_create_buf(false, true)
   local width = math.floor(vim.api.nvim_win_get_width(0) * configs.window.float.width.ratio)
   local height = math.floor(vim.api.nvim_win_get_height(0) * configs.window.float.height.ratio)
   local focusable = true
   local relative = "win"
   local anchor = "NW"
   local row = math.floor(vim.api.nvim_win_get_height(0) * (1 - configs.window.float.height.ratio) / 2)
   local col = math.floor(vim.api.nvim_win_get_width(0) * (1 - configs.window.float.width.ratio) / 2)
   local opts = {
      relative = relative,
      anchor = anchor,
      height = height,
      width = width,
      row = row,
      col = col,
   }
   local winid = vim.api.nvim_open_win(buf, true, opts)
   local signcolumn = configs.window.float.signcolumn and "yes" or "no"
   vim.api.nvim_win_set_option(winid, "signcolumn", signcolumn)
   vim.cmd("view " .. path)
   buf = vim.fn.bufnr("%")   -- the 'buf' variable might point wrong bufnr in re-opened file.
   local command = ':lua require("cheat").close_cheat_sheet(' .. tostring(buf) .. ")<CR>"
   vim.api.nvim_buf_set_keymap(buf, "n", "q", command, { noremap = true, silent = true })
   fn.print(command, configs.debug)
   fn.print("vim.fn.bufnr(%): " .. tostring(vim.fn.bufnr("%")), configs.debug)
   return buf
end

function M.close_cheat_sheet(cheatbuf)
   -- if cheatbuf == nil then   -- when called by "q" key, without arg.
   --    cheatbuf = vim.b.cheatbuf
   -- end
   vim.cmd("bd " .. cheatbuf)
end

-- Return cheat name from filename
-- ex.) 'test.md' --> 'md'
function M.getCheatName(filename)
   for name, patterns in pairs(configs.cheatsheets.filetypes) do
      for _, pattern in ipairs(patterns) do
         local lua_pattern = fn.bashPatternToLua(pattern)
         if filename:match(lua_pattern) then
            --
            return name
         end
      end
   end
   return nil
end

function M.getCheatPath(name)
   local cf = configs.file
   local filename = cf.prefix .. tostring(name) .. cf.ext
   local path = cf.dir .. "/" .. filename
   return path
end

function defineKeymaps()
   -- Keymaps
   local map = vim.keymap.set
   local opts = { silent = true, noremap = true }

   -- -- Cheatsheet (by filetypes)
   -- map({ "n" }, configs.keymaps.leader .. "h", ":lua require('cheat').toggle_cheat_sheet()<CR>", opts)

   -- -- Cheatsheets (Common)
   -- for name, item in pairs(configs.cheatsheets.commons) do
   --    local leader = configs.keymaps.leader
   --    local keymap = leader .. item.keymap
   --    local cheat_file_path = M.getCheatPath(name)
   --    local command = ':lua require("cheat").toggle_cheat_sheet("' .. cheat_file_path .. '")<CR>'
   --    map({ "n", "v" }, keymap, command, opts)
   -- end

   for keymap, command in pairs(configs.keymaps) do
      -- ["<leader>ch"] = require("cheat").toggle_cheat_sheet(),
      -- ["<leader>cn"] = require("cheat").toggle_cheat_sheet("nvim"),
      -- ["<leader>ct"] = require("cheat").toggle_cheat_sheet("tmux"),
      -- ["<leader>ch"] = ":Cheat<cr>",
      -- ["<leader>cn"] = ":Cheat nvim<cr>",
      -- ["<leader>ct"] = ":Cheat tmux<cr>",
      map({ "n", "v" }, keymap, command, opts)
   end
end

-- Define commands
function defineCommands()
   -- | Define Cheat command |
   vim.cmd([[command! -nargs=? -complete=command Cheat lua require('cheat').toggle_cheat_sheet(<q-args>)]])
end

-- print("init.lua end")

return M

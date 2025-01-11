local M = {}

local _loaded = false

-- Require
local fn = require('cheat.functions')
local opt = require('cheat.options')
local cmd = require('cheat.commands')
local key = require('cheat.keymaps')

-- Setup
function M.setup(user_options)
   -- Check already loaded or not
   if _loaded then return end
   _loaded = true

   local default_options = opt.default_options
   opt.update_options(default_options, user_options)
   -- key.defineKeymaps() -- use `keys = {}` instead
   cmd.defineCommands()
end

-- Toggle cheat sheet
function M.toggle_cheat_sheet(cheat_name, win_type)
   local path
   win_type = win_type or opt.opts.window.default
   if vim.b.cheatbuf ~= nil then -- Close existing cheatsheet
      M.close_cheat_sheet(vim.b.cheatbuf)
      vim.b.cheatbuf = nil
   else -- Open cheatsheet
      fn.print('cheat_name: ' .. tostring(cheat_name))
      if cheat_name == '' or cheat_name == nil then -- If no cheat_name was set, show cheat by filetypes.
         local filename = vim.fn.bufname('%')
         cheat_name = M.getCheatName(filename)
         path = M.getCheatPath(cheat_name)
      else -- If cheat_name was set.
         path = M.getCheatPath(cheat_name)
      end
      fn.print('path: ' .. tostring(path))
      fn.print('window: ' .. tostring(win_type))
      if win_type == 'vsplit' or win_type == 'hsplit' then
         vim.b.cheatbuf = M.open_cheat_sheet(path, win_type)
      elseif win_type == 'float' then
         vim.b.cheatbuf = M.open_cheat_sheet_float(path)
      end
   end
end

function M.open_cheat_sheet(path, win_type)
   -- Check if the file exists
   if not vim.fn.filereadable(path) then
      fn.print('Cheatsheet file does not exist.')
      return
   end

   local opts = require('cheat.options').opts

   win_type = win_type or opts.window.default
   local win_height = vim.o.lines
   local win_width = vim.o.columns

   if win_type == 'vsplit' then
      -- Determine the split position and size for vertical split
      local height = math.floor(win_height * opts.window.vsplit.height)
      if opts.window.vsplit.position == 'bottom' then
         -- Split with focus on the bottom window
         vim.cmd('botright ' .. height .. 'split')
      else -- 'top'
         -- Split with focus on the top window
         vim.cmd('topleft ' .. height .. 'split')
      end
   elseif win_type == 'hsplit' then
      -- Determine the split position and size for horizontal split
      local width = math.floor(win_width * opts.window.hsplit.width)
      if opts.window.hsplit.position == 'left' then
         -- Split with focus on the left window
         vim.cmd('topleft ' .. width .. 'vsplit')
      else -- 'right'
         -- Split with focus on the right window
         vim.cmd('botright ' .. width .. 'vsplit')
      end
   end

   -- Open the cheat sheet file in the new buffer
   local open_cmd = opts.readonly and 'view ' or 'edit '
   vim.cmd(open_cmd .. path)

   -- Debug logging if enabled
   fn.print('vim.fn.bufnr("%"): ' .. tostring(vim.fn.bufnr('%')))

   local buf = vim.fn.bufnr('%')

   -- Add close keymap
   local command = ':lua require("cheat").close_cheat_sheet(' .. tostring(buf) .. ')<CR>'
   vim.api.nvim_buf_set_keymap(buf, 'n', 'q', command, { noremap = true, silent = true })
   return buf
end

-- Open cheat sheet with floating window
function M.open_cheat_sheet_float(path)
   local opts = require('cheat.options').opts
   local buf = vim.api.nvim_create_buf(false, opts.readonly)
   local width = math.floor(vim.api.nvim_win_get_width(0) * opts.window.float.width)
   local height = math.floor(vim.api.nvim_win_get_height(0) * opts.window.float.height)
   local relative = 'win'
   local anchor = 'NW'
   local row = math.floor(vim.api.nvim_win_get_height(0) * (1 - opts.window.float.height) / 2)
   local col = math.floor(vim.api.nvim_win_get_width(0) * (1 - opts.window.float.width) / 2)
   local border = opts.window.float.border
   local win_opts = {
      relative = relative,
      anchor = anchor,
      height = height,
      width = width,
      row = row,
      col = col,
      border = border,
   }
   local winid = vim.api.nvim_open_win(buf, true, win_opts)
   local signcolumn = opts.window.float.signcolumn and 'yes' or 'no'
   vim.api.nvim_win_set_option(winid, 'signcolumn', signcolumn)
   local open_cmd = opts.readonly and 'view ' or 'edit '
   vim.cmd(open_cmd .. path)
   buf = vim.fn.bufnr('%') -- the 'buf' variable might point wrong bufnr in re-opened file.

   -- Add close keymap
   -- local key = require('cheat.keys')
   key.add_close_keymap(buf)

   return buf
end

function M.close_cheat_sheet(cheatbuf)
   -- if cheatbuf == nil then   -- when called by "q" key, without arg.
   --    cheatbuf = vim.b.cheatbuf
   -- end
   vim.cmd('bd ' .. cheatbuf)
end

-- Get the file-specific cheat_name from filename
-- ex.) 'test.md' --> 'md'
function M.getCheatName(filename)
   for name, patterns in pairs(opt.opts.cheatsheets.filetypes) do
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

-- Get the path from cheat name
function M.getCheatPath(cheat_name)
   local cf = opt.opts.file
   local filename = cf.prefix .. tostring(cheat_name) .. '.' .. cf.ext
   local path = cf.dir .. '/' .. filename
   return path
end

return M

local M = {}

-- Define keymaps
function M.defineKeymaps()
   local opts = require('cheat.options').opts
   -- Keymaps
   local map = vim.keymap.set
   local key_opts = { silent = true, noremap = true }

   for keymap, command in pairs(opts.keymaps) do
      map({ 'n', 'v' }, keymap, command, key_opts)
   end
end

-- Add close keymap

function M.add_close_keymap(buf)
   local command = ':lua require("cheat").close_cheat_sheet(' .. tostring(buf) .. ')<CR>'
   local keymap = require('cheat.options').opts.keymaps.close
   vim.api.nvim_buf_set_keymap(buf, 'n', keymap, command, { noremap = true, silent = true })
end

return M

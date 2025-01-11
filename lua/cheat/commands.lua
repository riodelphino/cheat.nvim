local M = {}

-- Valid window types
local WIN_TYPES = {
   'hsplit',
   'vsplit',
   'float',
}

-- Parse command arguments: filename [win_type]
local function parse_args(args)
   local words = vim.split(args, '%s+', { trimempty = true })

   -- Default values
   local filename = nil
   local win_type = 'float'

   -- First arg is filename if provided
   if #words >= 1 then filename = words[1] end

   -- Second arg is win_type if provided and valid
   if #words >= 2 and vim.tbl_contains(WIN_TYPES, words[2]) then win_type = words[2] end

   return filename, win_type
end

-- Command completion function
local function complete_args(arg_lead, cmdline, _)
   local args = vim.split(cmdline:sub(#'Cheat' + 1), '%s+', { trimempty = true })

   -- For second argument completion
   if #args >= 1 and arg_lead ~= args[1] then
      local matches = {}
      for _, win_type in ipairs(WIN_TYPES) do
         if vim.startswith(win_type, arg_lead) then table.insert(matches, win_type) end
      end
      return matches
   end

   -- TODO: Add filename completion for the first argument if needed
   return {}
end

function M.defineCommands()
   -- Main cheat command
   vim.api.nvim_create_user_command('Cheat', function(opts)
      local filename, win_type = parse_args(opts.args)
      require('cheat').toggle_cheat_sheet(filename, win_type)
   end, {
      nargs = '*',
      complete = complete_args,
      desc = 'Toggle cheat sheet: <filename> [win_type] (win_type: hsplit/vsplit/float)',
   })

   -- Create new cheat sheet
   vim.api.nvim_create_user_command('CheatNew', function(opts) require('cheat').create_cheat_sheet(opts.args) end, {
      nargs = '?',
      desc = 'Create new cheat sheet',
   })

   -- Delete cheat sheet
   vim.api.nvim_create_user_command('CheatDelete', function(opts) require('cheat').delete_cheat_sheet(opts.args) end, {
      nargs = '?',
      desc = 'Delete cheat sheet',
   })
end

return M

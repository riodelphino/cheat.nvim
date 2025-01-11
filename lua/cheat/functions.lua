-- print("functions.lua top")
local M = {}

-- Print tables as string & recursively
function M.print_table(t, indent)
   local debug = require('cheat.options').opts.debug
   if debug then
      indent = indent or "  "
      for k, v in pairs(t) do
         if type(v) == "table" then
            print(indent .. k .. " :")
            M.print_table(v, indent .. "  ")
         else
            print(indent .. k .. " : " .. tostring(v))
         end
      end
   end
end

function M.print(msg)
   local debug = require('cheat.options').opts.debug
   if debug then print(msg) end
end

-- Return splited args
function M.split_args(args)
   -- Args is "arg1" "arg2" "arg3" style string.
   local args_list
   if args == "" then   -- If no args was given, args == ""
      args_list = nil
   elseif args ~= nil then
      if type(args) == "string" then args_list = args end
      args_list = nil
   end
   return args_list
end

-- Convert Bash pattern to Lua pattern
function M.bashPatternToLua(pattern)
   --
   return pattern:gsub("%.", "%%."):gsub("%*", ".*")
end

function M.is_array(table)
   local is_array_flg = true
   for k, v in pairs(table) do
      if type(k) ~= 'number' or type(v) ~= 'string' then
         is_array_flg = false
         break
      end
   end
   return is_array_flg
end

function M.deep_merge(default, user)
   -- If `user` is not a table, use the `default` value
   if type(user) ~= 'table' then return default end

   -- Iterate through all keys in the default table
   for key, default_value in pairs(default) do
      if user[key] == nil then
         -- If the key is missing in the user table, use the default value
         user[key] = default_value
      elseif type(default_value) == 'table' then
         if M.is_array(default[key]) then -- If the value is a array, just overwrite all by user
            user[key] = user[key]
         else
            -- If the value is a table, recurse
            user[key] = M.deep_merge(default_value, user[key])
         end
      end
   end
   return user
end


return M

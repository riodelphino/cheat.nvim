-- print("functions.lua top")
local M = {}

-- Print tables as string & recursively
print_table = function(t, degug, indent)
   if debug then
      indent = indent or "  "
      for k, v in pairs(t) do
         if type(v) == "table" then
            print(indent .. k .. " :")
            print_table(v, indent .. "  ")
         else
            print(indent .. k .. " : " .. tostring(v))
         end
      end
   end
end

local print = function(msg, debug)
   if debug then print(msg) end
end

-- Return splited args
local split_args = function(args)
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
local bashPatternToLua = function(pattern)
   --
   return pattern:gsub("%.", "%%."):gsub("%*", ".*")
end

local M = {
   print = print,
   print_table = print_table,
   split_args = split_args,
   bashPatternToLua = bashPatternToLua,
   test = "aiueoaiueo",
}

-- print("functions.lua end")

return M

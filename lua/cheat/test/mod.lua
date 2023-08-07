-- mod.lua
local greet = function(name)
   local user_name = tostring(name) or "unname"
   print("Hello " .. user_name .. "!")
end

local add = function(x, y)
   local x_val = tonumber(x) or 0
   local y_val = tonumber(y) or 0

   return x_val + y_val
end

-- Register the function which you want to publish to the table member, and return.
return {
   greet = greet,
   add = add,
}

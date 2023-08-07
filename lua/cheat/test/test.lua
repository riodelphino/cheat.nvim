print("test.lua top")

local M = {}

local test = "foobar"
local myfunc = function()
   --
   return "foofoobarbar"
end

M = {
   test = test,
   myfunc = myfunc,
}

print("test.lua end")

return {
   test = test,
   myfunc = myfunc,
}

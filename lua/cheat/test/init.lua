-- print("init.lua top")
--
-- local mod = require("test")
-- print(mod.test)
-- print(mod.myfunc())

-- myscript.lua
local mod = require("mod")
mod.greet("utakamo")
print("add(10,20) = " .. mod.add(10, 20))

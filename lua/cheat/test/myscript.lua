-- myscript.lua
print(package.path)
package.loaded["mod"] = nil
local cur_dir = vim.fn.getcwd()
package.path = package.path .. ";" .. cur_dir .. "/?.lua"
print(package.path)

local mod = require("./mod")
mod.greet("utakamo")
print("add(10,20) = " .. mod.add(10, 20))

--  Title:        cheat.nvim
--  Description:  A plugin to show cheatsheet.
--  Last Change:  13 August 2023
--  Maintainer:   riodelphino <https://github.com/riodelphino>
--
--  Prevents the plugin from being loaded multiple times. If the loaded
--  variable exists, do nothing more. Otherwise, assign the loaded
--  variable and continue running this instance of the plugin.

if vim.g.loaded_cheat then return end

local cheat = require("cheat")
cheat.setup {}

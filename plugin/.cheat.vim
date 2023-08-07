" Title:        cheat.nvim
" Description:  A plugin to show cheatsheet file imediately.
" Last Change:  8 August 2023
" Maintainer:   riodelphino <https://github.com/riodelphino>

" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded
" variable and continue running this instance of the plugin.
if exists("g:loaded_cheat")
   finish
endif
let g:loaded_cheat = 1

" Defines a package path for Lua. This facilitates importing the
" Lua modules from the plugin's dependency directory.
let s:lua_rocks_deps_loc =  expand("<sfile>:h:r") . "/../lua/cheat"
exe "lua package.path = package.path .. ';" . s:lua_rocks_deps_loc . "/init.lua'"


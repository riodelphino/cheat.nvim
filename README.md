
# cheat.nvim

Quick & Usefull cheatsheet viewer plugin for nvim.

Inspired by [vim-cheatsheet](https://github.com/reireias/vim-cheatsheet)


## Functions

Both functions are available.

1. Show 'file-specific' cheatsheet, with the same one keymap.  
ex.) \<leader\>ch

2. Show 'commonly-used' cheatsheet, by each keymaps.  
ex.) \<leader\>ct --> tmux's cheatsheet  
ex.) \<leader\>cn --> nvim's cheatsheet


## Install

Packer
```lua
use { "riodelphino/cheat.nvim" }
```


## Setup
```lua
require('cheat').setup {}
```


## Usage

| Command      | Description                                                                                   |
|--------------|-----------------------------------------------------------------------------------------------|
| :Cheat       | Show the cheatsheet depending on filetype, with the style set in config.window.default_style. |
| :CheatFloat  | (Unimplemented) Show the cheatsheet depending on filetypes as float style.                    |
| :CheatHSplit | (Unimplemented) Show the cheatsheet depending on filetypes as horizontal split style.         |
| :CheatVSplit | (Unimplemented) Show the cheatsheet depending on filetypes as vertical split style.           |


## Default keymaps

| Keymap       | Function                                          |
|--------------|---------------------------------------------------|
| \<leader\>ch | Show the cheatsheet by current buf's file pattern |
| \<leader\>cn | Show the nvim's cheatsheet (cheat-nvim.md)        |
| \<leader\>ct | Show the tmux's cheatsheet (cheat-tmux.md)        |
| q            | Close cheatsheet.                                 |


## Config

Default configs.
```lua
rquire('cheat').setup {
   debug = false,  -- show debug msg
   window = {
      default_style = "float",     -- "vsplit", "hsplit" -- Choise display style.
      vsplit = { height = { size = 20 } },
      hsplit = { width = { size = 40 } },
      float = {
         width = {
            ratio = 0.8,
         },
         height = {
            ratio = 0.9,
         },
         signcolumn = false, -- 'false' for simple display style.
      },
   },
   file = {
      dir = "~/.config/nvim/cheat", -- Directory where the cheatsheets are placed.
      prefix = "cheat-", -- Cheatsheet file prefix.
      ext = ".md", -- Cheatsheet extension.
   },
   keymaps = {
      ["<leader>ch"] = ":Cheat", -- Show the cheatsheet depending on filetype.
      ["<leader>cn"] = ":Cheat nvim", -- Show "cheat-nvim.md"
      ["<leader>ct"] = ":Cheat tmux", -- Show "cheat-tmux.md"
   },
   cheatsheets = {
      filetypes = { -- Open the specific cheatsheet by file pattern.
         lua = { "*.lua" },
         vim = { "*.vim", "*.vifmrc" }, -- The key 'vim' is the surfix of filename. ex.) cheat-vim.md
         js = { "*.js", "*.mjs" },
         css = { "*.css", "*.scss", "*.sass" },  -- Multiple filetypes are allowed.
         md = { "*.md" },
         php = { "*.php" },
         html = { "*.html" },  -- You can add more filetypes settings.
      },
   },
}

```


## TODO

- [ ] window.default_style = "vsplit"
- [ ] window.default_style = "hsplit"
- [ ] window.vsplit.signcolumn
- [ ] window.vsplit.signcolumn
- [ ] Logging (now just print()...)


## Lisence
MIT


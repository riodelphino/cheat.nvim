
# cheat.nvim

Quick & Usefull cheatsheet viewer plugin for nvim.

Inspired by [vim-cheatsheet](https://github.com/reireias/vim-cheatsheet)


## Preview

### Show cheatsheets by user commands.
`:Cheat` or `:Cheat {cheat_name}`

https://github.com/riodelphino/cheat.nvim/assets/29378271/894b3c85-ddf0-49d1-b558-cb2e9f51948e

### Show cheatsheets by keymaps.
`<leader>ch` or `<leader>cn` or `<leader>ct`

https://github.com/riodelphino/cheat.nvim/assets/29378271/e6f044f1-fad1-4f7a-8283-8fe481c54366


## Functions

Both functions are available.

1. Show 'filetype-specific' cheatsheet automatically, with the same 'one' keymap.  
   ex.) `<leader>ch` or `:Cheat`

1. Show 'commonly-used' cheatsheet, by each keymaps.  
   ex.) `<leader>cn` or `:Cheat nvim` --> nvim's cheatsheet  
   ex.) `<leader>ct` or `:Cheat tmux` --> tmux's cheatsheet  


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

| Command             | Description                                                                                                    |
|---------------------|----------------------------------------------------------------------------------------------------------------|
| :Cheat              | Show the cheatsheet depending on current buf's filetype,<br>with the style set in config.window.default_style. |
| :CheatFloat         | (Unimplemented) Same with :Cheat, but with float style.                                                        |
| :CheatHSplit        | (Unimplemented) Same with :Cheat, but with horizontal split style.                                             |
| :CheatVSplit        | (Unimplemented) Same with :Cheat, but with vertical split style.                                               |
| :Cheat {cheat_name} | Same with :Cheat, but show the specific cheatsheet.                                                            |


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
      -- You can add more keymaps & cheatsheets here.
   },
   cheatsheets = {
      filetypes = { -- Open the specific cheatsheet by file pattern.
         lua = { "*.lua" },
         vim = { "*.vim", "*.vifmrc" }, -- The key 'vim' is the surfix of filename. ex.) cheat-vim.md
         js = { "*.js", "*.mjs" },
         css = { "*.css", "*.scss", "*.sass" },  -- Multiple filetypes are allowed.
         md = { "*.md" },
         php = { "*.php" },
         html = { "*.html" },
         -- You can add more filetypes settings here.
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


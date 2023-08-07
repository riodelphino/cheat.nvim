
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


## Usage
```lua
require('cheat').setup {}
```


## Config

Default configs.
```lua
rquire('cheat').setup {
   debug = false,  -- show debug msg
   window = {
      type = "float",     -- "vsplit", "hsplit" -- Choise display style.
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
      leader = "<Leader>c",
      default = "h", -- Open the 'by filetypes' cheatsheet.
   },
   cheatsheets = {
      commons = { -- Open commonly used cheatsheets, if you are opening any filetype of buf.
         nvim = { keymap = "n" },
         tmux = { keymap = "t" }, -- You can add more settings.
      },
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


## Default keymaps

| Keymap       | Function                                                |
|--------------|---------------------------------------------------------|
| \<leader\>ch | Show the cheatsheet by current buf's file pattern       |
| \<leader\>cn | Show the nvim's cheatsheet (cheat-nvim.md)              |
| \<leader\>ct | Show the tmux's cheatsheet (cheat-tmux.md)              |
| q            | Close cheatsheet. (Sorry, it doesn't work as expected.) |


## TODO

- [ ] window.type = "vsplit"
- [ ] window.type = "hsplit"
- [ ] window.vsplit.signcolumn
- [ ] window.vsplit.signcolumn
- [ ] Logging (now just use print()...)


## Disclaimer

I'm an amateur with little experience about nvim plugins, so please forgive me if the source is dirty.  
I want to refurbish them to separated modules...


## Lisence
MIT


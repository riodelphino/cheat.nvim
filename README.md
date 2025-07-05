
# cheat.nvim


> [!Caution]
> This project was deprecated.
> The same functionality can be achieved using picker in [snacks.nvim](https://github.com/folke/snacks.nvim) easier.

lazy.nvim:
```lua
return {
   'folke/snacks.nvim',
   opts = {},
   config = function()
      require('snacks').setup({
      })

      local cheat_files = {
         { path = cheat_dir .. 'sh.md', label = 'sh' },
         { path = cheat_dir .. 'git.md', label = 'git' },
         { path = cheat_dir .. 'nvim.md', label = 'nvim' },
         { path = cheat_dir .. 'tmux.md', label = 'tmux' },
         { path = cheat_dir .. 'yazi.md', label = 'yazi' },
         { path = cheat_dir .. 'taskwarrior.md', label = 'taskwarrior' },
         { path = cheat_dir .. 'macos_app.md', label = 'MacOS App' },
      }
   
      local base_opts = {
         style = 'float',
         focusable = true,
         width = 0.85,
         height = 0.85,
         position = 'float',
         border = 'rounded',
         enter = true,
         relative = 'editor',
         zindex = 50,
         buf = {
            buflisted = true,
            modifiable = true,
         },
         wo = {
            list = true,
            spell = false,
            wrap = false,
            number = true,
            signcolumn = 'yes',
            conceallevel = 3,
            cursorline = true,
         },
         keys = {
            q = 'close',
         },
      }
   
      local notify_opts = {
         title = 'Snacks',
      }
   
      function snacks_cheat_picker()
         vim.ui.select(cheat_files, {
            prompt = 'Cheat picker',
            format_item = function(item) return item.label end,
         }, function(choice)
            if choice then
               local opts = vim.deepcopy(base_opts)
               opts.file = choice.path
               Snacks.win(opts)
            end
         end)
      end
   end,
   keys = {
      { '<leader>Sc', function() snacks_cheat_picker() end, desc = 'Cheat picker' },
   }
}
```

Quick & Usefull cheatsheet viewer plugin for nvim.

Inspired by [vim-cheatsheet](https://github.com/reireias/vim-cheatsheet)

> [!Warning]
> Critical changes in ver1.1.0
> - Modified options totally
> - Changed default dir from `~/.config/nvim/cheat` to `~/.config/cheat`
> - Removed file prefix

See [## Default options](#default-options), and copy & paste to your settings.


> [!Note]
> Hsplit & Vsplit are implemented ! (v1.1.0~)
> (with `:Cheat {cheat-name} {float|hsplit|vsplit}`)


## Install

use Lazy.nvim
```lua
return {
   'riodelphino/cheat.nvim',
}
```

## Default options

```lua
opts = {
   debug = false, -- show debug msg (only for me)
   readonly = false, -- true | false  ... false for editable
   window = {
      default = 'float', -- float | vsplit | hsplit
      float = {
         width = 0.8, -- ratio for nvim window
         height = 0.9, -- ratio for nvim window
         signcolumn = false, -- true | false ... Show signcolumn or not
         number = true, -- true | false ... Show number or not
         border = 'single',  -- 'none'  'single' | 'double' | 'rounded' | 'solid'
      },
      vsplit = {
         height = 0.3, -- ratio for nvim window
         position = 'bottom', -- bottom | top
         signcolumn = false, -- true | false ... Show signcolumn or not
         number = true, -- true | false ... Show number or not
      },
      hsplit = {
         width = 0.5, -- ratio for nvim window
         position = 'left', -- left | right
         signcolumn = false, -- true | false ... Show signcolumn or not
         number = true, -- true | false ... Show number or not
      },
   },
   file = {
      dir = '~/.config/cheat.nvim', -- Cheatsheet directory
      prefix = '', -- Cheatsheet file's prefix.
      ext = 'md', -- Cheatsheet file's extension.
   },
   cheatsheets = {
      filetypes = { -- Open the specific cheatsheet by file pattern.
         lua = { '*.lua' }, -- will open 'lua.md' cheatsheet, if called on *.lua files
         vim = { '*.vim', '*.vifmrc' }, -- The key 'vim' is the surfix of filename. ex.) cheat-vim.md
         js = { '*.js', '*.mjs' },
         css = { '*.css', '*.scss', '*.sass' },  -- Multiple filetypes are allowed.
         md = { '*.md' },
         php = { '*.php' },
         html = { '*.html' },
         -- Add more filetypes settings here.
      },
   },
   keymaps = {
      close = 'q', -- The keymap to close current cheat sheet. '<ESC>' is also good
   },
},
```


## Usage

| Command                      | Description                                                                                                |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `:Cheat`                     | Show the cheatsheet depending on current buf's filetype,<br>with the style set in `config.window.default`. |
| `:Cheat {cheat_name}`        | Same with `:Cheat`, but show the specific cheatsheet.                                                      |
| `:Cheat {cheat_name} float`  | Same with `:Cheat`, but with floating window style.                                                        |
| `:Cheat {cheat_name} hsplit` | Same with `:Cheat`, but with horizontal split style.                                                       |
| `:Cheat {cheat_name} vsplit` | Same with `:Cheat`, but with vertical split style.                                                         |


## Keys

```lua
keys = {
   { '<leader>ch', ':Cheat<cr>', desc = 'Cheat' }, -- Just open the cheat sheet, for each filetype of the current buffer
   { '<leader>cn', ':Cheat nvim<cr>', desc = 'Cheat for nvim' }, -- Set your special cheat sheet, independent on filetype
   { '<leader>cg', ':Cheat git<cr>', desc = 'Cheat for git' }, -- Same above
   { '<leader>ct', ':Cheat todo<cr>', desc = 'Cheat for todo' }, -- Open your todo file
   { '<leader>cw', ':Cheat tmux hsplit<cr>', desc = 'Cheat for tmux (hsplit)' }, -- Open in specific win_type
},
```


## Lisence
MIT


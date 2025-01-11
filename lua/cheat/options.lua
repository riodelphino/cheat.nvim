local M = {}

M.opts = {}

-- Update all config recursively
function M.update_options(default_options, user_options)
   local fn = require('cheat.functions')
   M.opts = fn.deep_merge(default_options, user_options)
end

-- Default configuration
M.default_options = {
   debug = false, -- show debug msg (only for me)
   readonly = false, -- true | false  ... false for editable
   window = {
      default = 'float', -- float | vsplit | hsplit
      float = {
         width = 0.8, -- ratio for nvim window
         height = 0.9, -- ratio for nvim window
         signcolumn = false, -- true | false ... Show signcolumn or not
         number = true, -- true | false ... Show number or not
         border = 'single', -- 'none'  'single' | 'double' | 'rounded' | 'solid'
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
         css = { '*.css', '*.scss', '*.sass' }, -- Multiple filetypes are allowed.
         md = { '*.md' },
         php = { '*.php' },
         html = { '*.html' },
         -- Add more filetypes settings here.
      },
   },
   keymaps = {
      close = 'q',
   },
}

return M

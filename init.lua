vim.loader.enable()             -- faster startup
vim.g.loaded_netrw = 1          -- using nvim-tree instead
vim.g.loaded_netrwPlugin =1     -- using nvim-tree instead

require "user.autocommands"
require "user.colorscheme"
require "user.keymaps"
require "user.lsp"
require "user.options"
require "user.plugins"

-- debugger (dap, dapui) -- anything else needed to run nextjs/node apps
-- test runner?
-- whichkey
-- look into how to make the gitsigns / diffview highlighting more transparent
-- look into how to disable snippets, etc. when in text files/comments


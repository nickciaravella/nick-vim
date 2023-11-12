vim.loader.enable()             -- faster startup
vim.g.loaded_netrw = 1          -- using nvim-tree instead
vim.g.loaded_netrwPlugin =1     -- using nvim-tree instead

require "user.alpha"
require "user.autocommands"
require "user.autopairs"
require "user.cmp"
require "user.comment"
require "user.colorscheme"
require "user.diffview"
require "user.gitsigns"
require "user.indentline"
require "user.keymaps"
require "user.lsp"
require "user.lualine"
require "null-ls"
require "user.nvim-tree"
require "user.options"
require "user.plugins"
require "user.project"
require "user.telescope"
require "user.toggleterm"
require "user.treesitter"


-- debugger (dap) -- anything else needed to run nextjs/node apps
-- test runner?
-- whichkey
-- look into how to make the gitsigns / diffview highlighting more transparent
-- look into how to disable snippets, etc. when in text files/comments


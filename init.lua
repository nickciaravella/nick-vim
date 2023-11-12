vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin =1

require "user.autocommands"
require "user.autopairs"
require "user.cmp"
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
-- comment
-- see how to make everything load faster on start (or lazily?) - impatient.nvim says vim.loader.enable()
-- alpha (startup screen) - look into alternatives
-- look into how to make the gitsigns / diffview highlighting more transparent
-- look into how to disable snippets, etc. when in text files/comments


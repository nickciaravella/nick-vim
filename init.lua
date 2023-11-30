vim.loader.enable()             -- faster startup
vim.g.loaded_netrw = 1          -- using nvim-tree instead
vim.g.loaded_netrwPlugin =1     -- using nvim-tree instead


require "user.autocommands"
require "user.keymaps"
require "user.options"
require "user.plugins"
require "user.colorscheme"
require "user.lsp"

-- debugger (dap, dapui) -- anything else needed to run nextjs/node apps
-- test runner?
-- whichkey
-- look into how to disable snippets, etc. when in text files/comments

-- nvim-lint (Dreams of Code Youtube - The almost perfect Noevim setup for nodejs)
-- hrsh7th/cmp-nvim-lsp-signature-help
-- do i need a formatter for prettier w/o null-ls?


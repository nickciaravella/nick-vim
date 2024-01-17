vim.loader.enable()             -- faster startup
-- vim.g.loaded_netrw = 1          -- using nvim-tree instead
-- vim.g.loaded_netrwPlugin =1     -- using nvim-tree instead
vim.g.nvim_tree_disable_netrw = 0  -- Using this to enable :GBrowse. Maybe revert if NVimTree has issues..

require "user.autocommands"
require "user.keymaps"
require "user.options"

-- Automatically install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

lazy.setup("plugins")

require "user.colorscheme"
require "user.lsp"

-- debugger (dap, dapui) -- anything else needed to run nextjs/node apps
-- test runner?
-- whichkey
-- look into how to disable snippets, etc. when in text files/comments

-- nvim-lint (Dreams of Code Youtube - The almost perfect Noevim setup for nodejs)
-- hrsh7th/cmp-nvim-lsp-signature-help
-- do i need a formatter for prettier w/o null-ls?


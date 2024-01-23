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

require "user.colorscheme" -- Move to lazy
require "user.lsp"


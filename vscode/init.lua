
local opts = { noremap = true, silent = true }

--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clipboard interaction
vim.g.clipboard = vim.g.vscode_clipboard
vim.opt["clipboard"] = "unnamedplus"
vim.keymap.set("v", "p", '"_dP', opts)

-- Window navigation
vim.keymap.set("n", "<C-h>", function() vim.fn.VSCodeNotify("workbench.action.navigateLeft") end, opts)
vim.keymap.set("n", "<C-j>", function() vim.fn.VSCodeNotify("workbench.action.navigateDown") end, opts)
vim.keymap.set("n", "<C-k>", function() vim.fn.VSCodeNotify("workbench.action.navigateUp") end, opts)
vim.keymap.set("n", "<C-l>", function() vim.fn.VSCodeNotify("workbench.action.navigateRight") end, opts)

-- Tab navigation
vim.keymap.set("n", "<S-h>", function() vim.fn.VSCodeNotify("workbench.action.nextEditorInGroup") end, opts)
vim.keymap.set("n", "<S-l>", function() vim.fn.VSCodeNotify("workbench.action.previousEditorInGroup") end, opts)
vim.keymap.set("n", "<leader>fo", function() vim.fn.VSCodeNotify("workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup") end, opts)

-- Errors
vim.keymap.set("n", "<leader>ee", function() vim.fn.VSCodeNotify("workbench.actions.view.problems") end)
vim.keymap.set("n", "<leader>ej", function() vim.fn.VSCodeNotify("editor.action.marker.next") end)
vim.keymap.set("n", "<leader>ek", function() vim.fn.VSCodeNotify("editor.action.marker.previous") end)


local opts = { noremap = true, silent = true }
local vscode = require("vscode")

--Remap space as leader key
vim.keymap.set("n", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clipboard interaction
vim.g.clipboard = vim.g.vscode_clipboard
vim.opt["clipboard"] = "unnamedplus"
vim.keymap.set("v", "p", '"_dP', opts)

-- Editor
vim.keymap.set("n", "<leader>e", function()
	vscode.action("workbench.action.closeSidebar")
	vscode.action("workbench.action.closePanel")
end, opts)

--Window navigation
vim.keymap.set("n", "<C-h>", function()
	vscode.action("workbench.action.navigateLeft")
end, opts)
vim.keymap.set("n", "<C-j>", function()
	vscode.action("workbench.action.navigateDown")
end, opts)
vim.keymap.set("n", "<C-k>", function()
	vscode.action("workbench.action.navigateUp")
end, opts)
vim.keymap.set("n", "<C-l>", function()
	vscode.action("workbench.action.navigateRight")
end, opts)

-- Tab navigation
vim.keymap.set("n", "<S-h>", function()
	vscode.action("workbench.action.previousEditorInGroup")
end, opts)
vim.keymap.set("n", "<S-l>", function()
	vscode.action("workbench.action.nextEditorInGroup")
end, opts)
vim.keymap.set("n", "<leader>fo", function()
	vscode.action("workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup")
end, opts)
vim.keymap.set("c", "bd", "tabc", opts) -- no buffers in VSCode, so instead close the tab.

-- Errors
vim.keymap.set("n", "<leader>p", function()
	vscode.action("workbench.actions.view.problems")
end)
vim.keymap.set("n", "]d", function()
	vscode.action("editor.action.marker.next")
end)
vim.keymap.set("n", "[d", function()
	vscode.action("editor.action.marker.prev")
end)

-- LSP
vim.keymap.set("n", "gr", function()
	vscode.action("editor.action.goToReferences")
end)

-- Finding and searching (telescope style)
vim.keymap.set("n", "<leader>ff", function()
	vscode.action("workbench.action.quickOpen")
end, opts)

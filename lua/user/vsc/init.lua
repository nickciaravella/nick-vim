local opts = { noremap = true, silent = true }
local vscode = require("vscode")

--Remap space as leader key
vim.keymap.set("n", "<SPACE>", "<NOP>", opts)
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
vim.keymap.set("n", "<leader>b", function()
	vscode.action("workbench.action.toggleSidebarVisibility")
end, opts)
vim.keymap.set("n", "<leader>j", function()
	vscode.action("workbench.action.togglePanel")
end, opts)

-- Closing editors
vim.keymap.set("n", "<leader>bda", function()
	vscode.action("workbench.action.closeAllEditors")
end, opts)
vim.keymap.set("n", "<leader>bdo", function()
	vscode.action("workbench.action.closeOtherEditors")
end, opts)
vim.keymap.set("n", "<leader>bg", function()
	vscode.action("workbench.action.closeEditorsAndGroup")
end, opts)

-- File explorer
vim.keymap.set("n", "-", function()
	vscode.action("workbench.files.action.showActiveFileInExplorer")
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
vim.keymap.set("n", "<C-n>", function()
	vscode.action("workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup")
end, opts)
vim.keymap.set("c", "bd", "tabc", opts)
--
-- LSP
vim.keymap.set("n", "gr", function()
	vscode.action("editor.action.goToReferences")
end, opts)
-- vim.keymap.set("n", "<leader>gr", function()
-- 	vscode.action("editor.action.openReferenceToSide")
-- end, opts)
-- vim.keymap.set("n", "<leader>gd", function()
-- 	vscode.action("editor.action.revealDefinitionAside")
-- end, opts)
vim.keymap.set("n", "<C-/>", function()
	vscode.action("editor.action.quickFix")
end, opts)
vim.keymap.set("n", "<S-k>", function()
	vscode.action("editor.action.showHover")
end, opts)
vim.keymap.set("n", "<leader>rr", function()
	vscode.action("editor.action.rename")
end, opts)

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

-- Source control
vim.keymap.set("n", "<leader>go", function()
	vscode.action("workbench.scm.focus")
end)
vim.keymap.set("n", "<leader>gb", function()
	vscode.action("git.checkout")
end)
vim.keymap.set("n", "<leader>gc", function()
	vscode.action("git.commit")
end)
vim.keymap.set("n", "<leader>gC", function()
	vscode.action("git.commitAll")
end)
vim.keymap.set("n", "<leader>gp", function()
	vscode.action("git.pull")
end)
vim.keymap.set("n", "<leader>gP", function()
	vscode.action("git.push")
end)
vim.keymap.set("n", "<leader>gd", function()
	vscode.action("git.openChange")
end, opts)
vim.keymap.set("n", "]c", function()
	vscode.action("workbench.action.editor.nextChange")
end)
vim.keymap.set("n", "[c", function()
	vscode.action("workbench.action.editor.previousChange")
end)

-- Finding and searching (telescope style)
vim.keymap.set("n", "<leader>ff", function()
	vscode.action("workbench.action.quickOpen")
end, opts)
vim.keymap.set("n", "<leader>fb", function()
	vscode.action("workbench.action.showAllEditorsByMostRecentlyUsed")
end, opts)
vim.keymap.set("n", "<leader>ft", function()
	vscode.action("workbench.action.quickTextSearch")
end, opts)
vim.keymap.set("n", "<leader>fs", function()
	vscode.action("workbench.action.showAllSymbols")
end, opts)
vim.keymap.set("n", "<leader>fp", function()
	vscode.action("projectManager.listProjects")
end, opts)
vim.keymap.set("n", "<leader>fc", function()
	vscode.action("workbench.action.showCommands")
end, opts)

-- Breadcrumbs for symbol naviagtion (similar to Aerial)
vim.keymap.set("n", "<leader>ao", function()
	vscode.action("breadcrumbs.toggleToOn")
end, opts)

-- Tasks
vim.keymap.set("n", "<leader>tr", function()
	vscode.action("workbench.action.tasks.runTask")
end, opts)
vim.keymap.set("n", "<leader>tl", function()
	vscode.action("workbench.action.tasks.reRunTask")
end, opts)
vim.keymap.set("n", "<leader>tx", function()
	vscode.action("workbench.action.tasks.terminate")
end, opts)

-- Debugger
vim.keymap.set("n", "<leader>da", function()
	vscode.action("extension.pwa-node-debug.attachNodeProcess")
end, opts)
vim.keymap.set("n", "<leader>dd", function()
	vscode.action("workbench.action.debug.disconnect")
end, opts)
vim.keymap.set("n", "<leader>db", function()
	vscode.action("editor.debug.action.toggleBreakpoint")
end, opts)
vim.keymap.set("n", "<leader>dc", function()
	vscode.action("workbench.action.debug.continue")
end, opts)
vim.keymap.set("n", "<leader>dl", function()
	vscode.action("editor.debug.action.runToCursor")
end, opts)
vim.keymap.set("n", "]b", function()
	vscode.action("editor.debug.action.goToNextBreakpoint")
end, opts)
vim.keymap.set("n", "[b", function()
	vscode.action("editor.debug.action.goToPreviousBreakpoint")
end, opts)

-- Visual mode --
vim.keymap.set("v", "<", "<gv^", opts) -- Keep indentation highlighted
vim.keymap.set("v", ">", ">gv^", opts)

vim.keymap.set("v", "p", "pgvy", opts)

vim.keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv", opts)

vim.keymap.set("n", "<leader>ih", function()
	local enum = vscode.get_config("typescript.inlayHints.enumMemberValues.enabled")
	if enum then
		vscode.update_config("typescript.inlayHints.enumMemberValues.enabled", false)
	else
		vscode.update_config("typescript.inlayHints.enumMemberValues.enabled", true)
	end

	local parameter = vscode.get_config("typescript.inlayHints.parameterNames.enabled")
	if parameter == "all" then
		vscode.update_config("typescript.inlayHints.parameterNames.enabled", "none")
	else
		vscode.update_config("typescript.inlayHints.parameterNames.enabled", "all")
	end

	local property = vscode.get_config("typescript.inlayHints.propertyDeclarationTypes.enabled")
	if property then
		vscode.update_config("typescript.inlayHints.propertyDeclarationTypes.enabled", false)
	else
		vscode.update_config("typescript.inlayHints.propertyDeclarationTypes.enabled", true)
	end
end, opts)

vim.notify = vscode.notify

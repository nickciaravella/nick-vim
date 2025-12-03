local M = {}

-- Servers that will be installed by mason-lspconfig and configured by nvim-lspconfig
-- These are LspConfig server names, see here:
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
M.servers = {
	"cssls", -- CSS
	"gopls", -- Go
	"eslint",
	"html", -- HTML
	"jedi_language_server", -- Python
	"jsonls", -- JSON
	"lua_ls", -- Lua
	"prismals", -- Prisma Schema files.
	"tailwindcss", -- Tailwind CSS
	"tsgo", -- Typescript, Go server
	"yamlls", -- YAML
}

-- Setup styles
M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false, -- show help text inline
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)
	-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	-- 	border = "rounded",
	-- })
	--
	-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	-- 	border = "rounded",
	-- })
end
-- Keymaps for LSP related navigation
local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>hi", "<CMD>lua vim.lsp.buf.document_highlight()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ho", "<CMD>lua vim.lsp.buf.clear_references()<CR>", opts)

	-- First becomes available around version 0.10
	vim.keymap.set("n", "<leader>ih", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end, { desc = "Toggle [I]nlay [H]ints" })
end

M.on_attach = function(client, bufnr)
	M.setup()

	-- Don't use the LSP for formatting Typescript, will be done by conform.nvim
	if client.name == "tsgo" then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.textDocument_prepareCallHierarchy = true
	end

	if client.name == "eslint" or client.name == "tailwindcss" or client.name == "copilot" then
		-- These LSPs provide no value to readonly typing files, and on very large ones that we get to
		-- from "go to definition", it slows down the editor unnecessarily.
		-- Using defer_fn because there is currently no "should_attach" callback and we can only detach after
		-- the LSP has completed attaching.
		if string.find(vim.api.nvim_buf_get_name(bufnr), ".d.ts$") then
			vim.defer_fn(function()
				vim.lsp.buf_detach_client(bufnr, client.id)
				vim.notify(
					"Detached " .. client.name .. " from .d.ts file.",
					vim.log.levels.INFO,
					{ title = "LSP Detached" }
				)
			end, 500)
		end
	end

	if client.name == "lua_ls" then
		client.server_capabilities.documentFormattingProvider = false
	end
	if client.name == "eslint" then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.workspaceSymbolProvider = false
	end
	if client.name == "copilot" then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.workspaceSymbolProvider = false
	end

	lsp_keymaps(bufnr)
end

return M

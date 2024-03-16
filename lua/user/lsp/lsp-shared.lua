local M = {}

local cmp_nvim_lsp = require("cmp_nvim_lsp")
local illuminate = require("illuminate")

-- Servers that will be installed by mason-lspconfig and configured by nvim-lspconfig
-- These are LspConfig server names, see here:
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
M.servers = {
	"jedi_language_server", -- Python
	"lua_ls", -- Lua
	"cssls", -- CSS
	"html", -- HTML
	--"tsserver", -- Typescript -- Using typescript-tools instead.
	"eslint",
	"jsonls", -- JSON
	"prismals", -- Prisma Schema files.
	"yamlls", -- YAML
}

-- Configure capabilities to have autocomplete
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

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

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end
-- Keymaps for LSP related navigation
local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "i", "C-k", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

	-- First becomes available around version 0.10
	-- if vim.lsp.inlay_hint then
	-- 	vim.keymap.set("n", "<leader>ih", function()
	-- 		vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
	-- 	end, { desc = "Toggle [I]nlay [H]ints" })
	-- end
end

M.on_attach = function(client, bufnr)
	M.setup()

	-- Don't use the LSP for formatting Typescript, will be done by a formatter in Null-LS
	if client.name == "typescript-tools" then
		client.server_capabilities.documentFormattingProvider = false
	end
	if client.name == "eslint" then
		client.server_capabilities.documentFormattingProvider = false
	end
	if client.name == "lua_ls" then
		client.server_capabilities.documentFormattingProvider = false
	end

	lsp_keymaps(bufnr)
	-- vim.lsp.inlay_hint.enable(bufnr, true)
	illuminate.on_attach(client)
end

return M

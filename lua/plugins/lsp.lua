local servers = {
	"cssls", -- CSS
	"gopls", -- Go
	"eslint", -- ESLint
	"html", -- HTML
	"jedi_language_server", -- Python
	"jsonls", -- JSON
	"lua_ls", -- Lua
	"prismals", -- Prisma Schema files.
	"tailwindcss", -- Tailwind CSS
	"ts_ls", -- Typescript/JavaScript
	-- "tsgo",                 -- Typescript, Go server - not ready for prime time yet.
	"yamlls", -- YAML
}

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		-- Without these keymaps, [d and ]d go to the next diagnostic, but don't show the floating window.
		vim.keymap.set("n", "[d", "<CMD>lua vim.diagnostic.goto_prev()<CR>", { desc = "[D]iagnostics - Previous" })
		vim.keymap.set("n", "]d", "<CMD>lua vim.diagnostic.goto_next()<CR>", { desc = "[D]iagnostics - Next" })

		local id = vim.tbl_get(event, "data", "client_id")
		local client = id and vim.lsp.get_client_by_id(id)
		if client == nil then
			return
		end

		if client.name == "eslint" then
			-- If there are any issues, performance or duplicates, re-enable this line
			-- client.server_capabilities.workspaceSymbolProvider = false
		end

		if client.name == "eslint" or client.name == "tailwindcss" then
			-- These LSPs provide no value to readonly typing files, and on very large ones that we get to
			-- from "go to definition", it slows down the editor unnecessarily.
			-- Using defer_fn because there is currently no "should_attach" callback and we can only detach after
			-- the LSP has completed attaching.
			local bufnr = event.buf
			if string.find(vim.api.nvim_buf_get_name(bufnr), "%.d%.ts$") then
				vim.defer_fn(function()
					if not vim.api.nvim_buf_is_valid(bufnr) then
						return
					end

					vim.lsp.buf_detach_client(bufnr, client.id)
					vim.notify(
						"Detached " .. client.name .. " from .d.ts file.",
						vim.log.levels.INFO,
						{ title = "LSP Detached" }
					)
				end, 500)
			end
		end
	end,
})

return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = servers,
				automatic_enable = servers,
			})

			-- add support for tools (mason-tool-installer), next time i need to
			-- install prettierd or something

			-- mason-lspconfig setups up lsp servers with defaults
			-- and enables them. For extra customization, put additional
			-- configuration into after/lsp/<server>.lua files.
		end,
	},
}

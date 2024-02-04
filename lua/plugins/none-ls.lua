return {
	"nvimtools/none-ls.nvim",
	opts = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		return {
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier, -- TODO: Look into prettierd
				-- null_ls.builtins.diagnostics.eslint,  -- Using eslint lsp server instead.
				-- null_ls.builtins.completion.spell,
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

					-- Call formatter on file save.
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		}
	end,
}

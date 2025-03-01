local shared = require("user.lsp.lsp-shared")

-- Set LSP related keymaps
vim.keymap.set("n", "<S-k>", "<CMD>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "[d", "<CMD>lua vim.diagnostic.goto_prev()<CR>", { desc = "[D]iagnostics - Previous" })
vim.keymap.set("n", "]d", "<CMD>lua vim.diagnostic.goto_next()<CR>", { desc = "[D]iagnostics - Next" })
vim.keymap.set("n", "<C-.>", "<CMD>lua vim.lsp.buf.code_action()<CR>", { desc = "[D]iagnostics - [F]ix" })

return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			local mason = require("mason")
			mason.setup({
				ui = {
					border = "none",
					icons = {
						package_installed = "◍",
						package_pending = "◍",
						package_uninstalled = "◍",
					},
				},
				log_level = vim.log.levels.INFO,
				max_concurrent_installers = 4,
			})

			local mason_tool_installer = require("mason-tool-installer")
			mason_tool_installer.setup({
				-- linters
				ensure_installed = {
					"golangci-lint",
					"prettierd",
					"cspell",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
		opts = function()
			return {
				-- lsp servers
				ensure_installed = shared.servers,
				automatic_installation = true,
			}
		end,
	},
	{
		"neovim/nvim-lspconfig",
		main = "lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local opts = {}

			for _, server in pairs(shared.servers) do
				opts = {
					on_attach = shared.on_attach,
					capabilities = shared.capabilities,
				}
				server = vim.split(server, "@")[1]

				local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
				if require_ok then
					opts = vim.tbl_deep_extend("force", conf_opts, opts)
				end
				lspconfig[server].setup(opts)
			end
		end,
	},
}

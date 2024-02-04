local shared = require("user.lsp.lsp-shared")

return {
	{
		"williamboman/mason.nvim",
		opts = {
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
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
		opts = function()
			-- local mason_servers = table.insert(shared.servers, "tsserver")
			return {
				ensure_installed = shared.servers, --mason_servers,
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

return {
	"stevearc/conform.nvim",
	event = "BufRead",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { { "prettierd", "prettier" } },
			typescript = { { "prettierd", "prettier" } },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}

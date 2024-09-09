return {
	"folke/trouble.nvim",
	opts = {}, -- for default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	keys = {
		{ "<leader>d", "<CMD>Trouble diagnostics toggle<CR>" },
		{ "<leader>D", "<CMD>Trouble diagnostics toggle filter.buf=0<CR>" },
	},
}

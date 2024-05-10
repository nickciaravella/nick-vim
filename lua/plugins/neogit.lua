return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = true,
	keys = {
		{ "<leader>to", "<cmd>Neogit kind=vsplit<CR>" },
		{ "<leader>tp", "<cmd>Neogit push<CR>" },
		{ "<leader>tc", "<cmd>Neogit commit<CR>" },
	},
	cmd = {
		"Neogit",
	},
}

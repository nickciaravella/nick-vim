return {
	"stevearc/aerial.nvim",
	opts = {
		layout = {
			default_direction = "float",
			max_width = { 80, 0.5 },
			min_width = 50,
		},
		-- autojump = true,
		float = {
			relative = "editor",
		},
	},
	-- Optional dependencies
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{
			"<leader>ao",
			function()
				require("aerial").snacks_picker({
					layout = {
						preset = "select",
					},
				})
			end,
		},
	},
}

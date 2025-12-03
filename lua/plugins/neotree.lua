return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
		keys = {
			{
				"<leader>e",
				"<cmd>Neotree toggle source=filesystem reveal=true<cr>",
				desc = "Open NeoTree to Current File",
			},
			{ "-", "<cmd>Neotree toggle source=filesystem reveal=true<cr>", desc = "Open NeoTree to Current File" },
		},
	},
}

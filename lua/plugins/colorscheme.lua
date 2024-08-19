return {
	{
		"lunarvim/darkplus.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			-- local colorscheme = "darkplus"
			-- vim.cmd("colorscheme " .. colorscheme)
		end,
	},
	{
		"ful1e5/onedark.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			-- local colorscheme = "onedark"
			-- vim.cmd("colorscheme " .. colorscheme)
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local colorscheme = "tokyonight-night"
			vim.cmd("colorscheme " .. colorscheme)
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- to see it, rerun after everytinng else loads
			-- require("kanagawa").load("dragon")
		end,
	},
}

return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				contrast = "hard",
				overrides = {
					SnacksDashboardDesc = { link = "GruvboxGreen" },
					SnacksDashboardIcon = { link = "GruvboxGreen" },
					SnacksDashboardKey = { link = "GruvboxGreen" },
				},
			})
			vim.o.background = "light"
			vim.cmd("colorscheme gruvbox")
		end,
	},
}

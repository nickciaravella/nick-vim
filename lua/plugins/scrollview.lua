return {
	"dstein64/nvim-scrollview",
	event = "VeryLazy",
	config = function()
		require("scrollview").setup({
			excluded_filetypes = { "neo-tree" },
			current_only = true,
		})
	end,
}

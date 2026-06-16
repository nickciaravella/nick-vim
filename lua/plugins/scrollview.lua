return {
	"dstein64/nvim-scrollview",
	event = "VeryLazy",
	config = function()
		require("scrollview").setup({
			excluded_filetypes = {
				"snacks_dashboard",
				"snacks_picker_input",
				"snacks_picker_list",
				"snacks_picker_preview",
			},
			current_only = true,
		})
	end,
}

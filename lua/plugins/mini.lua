return {
	{
		"echasnovski/mini.ai",
		version = "*",
		config = function()
			-- Keybinds: https://github.com/echasnovski/mini.surround?tab=readme-ov-file#features
			require("mini.ai").setup()
		end,
	},
	{
		"echasnovski/mini.comment",
		version = "*",
		config = function()
			require("mini.comment").setup()
		end,
	},
	{
		"echasnovski/mini.surround",
		version = "*",
		config = function()
			-- Keybinds: https://github.com/echasnovski/mini.surround?tab=readme-ov-file#features
			require("mini.surround").setup()
		end,
	},
}

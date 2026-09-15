return {
	{
		"nvim-mini/mini.ai",
		version = "*",
		config = function()
			-- Keybinds: https://github.com/nvim-mini/mini.ai?tab=readme-ov-file#features
			require("mini.ai").setup()
		end,
	},
	{
		"nvim-mini/mini.surround",
		version = "*",
		config = function()
			-- Keybinds: https://github.com/nvim-mini/mini.surround?tab=readme-ov-file#features
			require("mini.surround").setup()
		end,
	},
}

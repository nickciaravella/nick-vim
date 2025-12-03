return {
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("catppuccin").setup({
	-- 			flavour = "mocha",
	-- 			integrations = {
	-- 				aerial = true,
	-- 				cmp = true,
	-- 				diffview = true,
	-- 				gitsigns = true,
	-- 				harpoon = true,
	-- 				indent_blankline = {
	-- 					enabled = false,
	-- 					scope_color = "lavender",
	-- 					color_indent_levels = true,
	-- 				},
	-- 				dap = true,
	-- 				dap_ui = true,
	-- 				mason = true,
	-- 				neogit = true,
	-- 				noice = true,
	-- 				notify = true,
	-- 				treesitter = true,
	-- 				native_lsp = {
	-- 					enabled = true,
	-- 					virtual_text = {
	-- 						errors = { "italic" },
	-- 						hints = { "italic" },
	-- 						warnings = { "italic" },
	-- 						information = { "italic" },
	-- 						ok = { "italic" },
	-- 					},
	-- 					underlines = {
	-- 						errors = { "undercurl" },
	-- 						hints = { "undercurl" },
	-- 						warnings = { "undercurl" },
	-- 						information = { "undercurl" },
	-- 						ok = { "undercurl" },
	-- 					},
	-- 					inlay_hints = {
	-- 						background = true,
	-- 					},
	-- 				},
	-- 				navic = {
	-- 					enabled = true,
	-- 					custom_bg = "NONE", -- "lualine" will set background to mantle
	-- 				},
	-- 				telescope = true,
	-- 				lsp_trouble = true,
	-- 				dadbod_ui = true,
	-- 			},
	-- 		})
	--
	-- 		local colorscheme = "catppuccin"
	-- 		vim.cmd("colorscheme " .. colorscheme)
	-- 	end,
	-- },
	-- {
	-- 	"lunarvim/darkplus.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {},
	-- 	config = function()
	-- 		local colorscheme = "darkplus"
	-- 		vim.cmd("colorscheme " .. colorscheme)
	-- 	end,
	-- },
	-- {
	-- 	"ful1e5/onedark.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {},
	-- 	config = function()
	-- 		vim.cmd("colorscheme " .. colorscheme)
	-- 		local colorscheme = "onedark"
	-- 	end,
	-- },
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		local colorscheme = "tokyonight-night"
	-- 		vim.cmd("colorscheme " .. colorscheme)
	-- 	end,
	-- },
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		-- to see it, rerun after everytinng else loads
	-- 		require("kanagawa").load("dragon")
	-- 	end,
	-- },
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				contrast = "hard",
			})
			vim.o.background = "light"
			vim.cmd("colorscheme " .. "gruvbox")
		end,
	},
}

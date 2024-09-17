return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	opts = {
		options = {
			icons_enabled = true,
			theme = "catppuccin",
			-- theme = "tokyonight",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = { "NvimTree" },
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = {
				{
					require("noice").api.statusline.mode.get,
					cond = require("noice").api.statusline.mode.has,
					-- color = { fg = "#ff9e64" },
				},
			},
			lualine_x = { "diff" },
			lualine_y = { "filetype" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = {}, --"filename" },
			lualine_x = {},
			lualine_y = { "filetype" },
			lualine_z = { "location" },
		},
		tabline = {},
		winbar = {
			lualine_a = {},
			lualine_b = { { "filename", path = 0 } },
			lualine_c = {
				{
					"navic",
					color_correction = nil,
					navic_opts = nil,
				},
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		inactive_winbar = {
			lualine_a = {},
			lualine_b = { { "filename", path = 0 } },
			lualine_c = {
				{
					"navic",
					color_correction = nil,
					navic_opts = nil,
				},
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		extensions = {},
	},
}

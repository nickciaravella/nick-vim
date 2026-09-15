local function recording()
	local register = vim.fn.reg_recording()
	return register ~= "" and "recording @" .. register or ""
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	opts = {
		options = {
			icons_enabled = true,
			theme = "gruvbox",
			-- theme = "catppuccin",
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
			lualine_c = { { "lsp_status", icon = "", symbols = { done = "", separator = ", " } } },
			lualine_x = { recording, "%S", "diff" },
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
	config = function(_, opts)
		require("lualine").setup(opts)
		-- lualine only refreshes on a timer; RecordingLeave fires before reg_recording() clears
		vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
			group = vim.api.nvim_create_augroup("lualine-recording", { clear = true }),
			callback = vim.schedule_wrap(function()
				require("lualine").refresh()
			end),
		})
	end,
}

local function recording()
	local register = vim.fn.reg_recording()
	return register ~= "" and "recording @" .. register or ""
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	opts = {
		options = { theme = "gruvbox" },
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
			lualine_c = { "navic" },
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		inactive_winbar = {
			lualine_a = {},
			lualine_b = { { "filename", path = 0 } },
			lualine_c = { "navic" },
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

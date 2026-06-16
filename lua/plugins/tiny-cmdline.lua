return {
	"rachartier/tiny-cmdline.nvim",
	init = function()
		vim.opt.cmdheight = 0

		local ok, ui2 = pcall(require, "vim._core.ui2")
		if ok then
			ui2.enable({})
		end
	end,
	config = function()
		local function set_cmdline_highlights()
			local border = vim.api.nvim_get_hl(0, { name = "FloatBorder", link = false })
			local normal = vim.api.nvim_get_hl(0, { name = "MsgArea", link = false })

			vim.api.nvim_set_hl(0, "TinyCmdlineBorder", {
				fg = border.fg,
				bg = normal.bg,
			})
		end

		require("tiny-cmdline").setup({
			width = {
				value = "50%",
				min = 40,
				max = 80,
			},
			border = "rounded",
			native_types = { "/", "?" }, -- Keep search native to avoid the reserved cmdheight row
			on_reposition = require("tiny-cmdline").adapters.blink,
		})

		set_cmdline_highlights()

		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("tiny-cmdline-highlights", { clear = true }),
			callback = set_cmdline_highlights,
		})
	end,
}

return {
	"rachartier/tiny-cmdline.nvim",
	init = function()
		require("vim._core.ui2").enable({})
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
			width = { value = "50%" },
			on_reposition = require("tiny-cmdline").adapters.blink,
		})

		set_cmdline_highlights()

		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("tiny-cmdline-highlights", { clear = true }),
			callback = set_cmdline_highlights,
		})
	end,
}

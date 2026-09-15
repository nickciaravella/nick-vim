return {
	"lewis6991/gitsigns.nvim",
	event = "BufRead",
	opts = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
		},
		numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
		attach_to_untracked = true,
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		preview_config = { border = "single" },
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gs.nav_hunk("next")
				end
			end)

			map("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gs.nav_hunk("prev")
				end
			end)

			map("n", "<leader>gd", gs.preview_hunk_inline)
			map("n", "<leader>gb", gs.toggle_current_line_blame)
			map("n", "<leader>gS", function()
				gs.toggle_signs()
				gs.toggle_numhl()
			end)
		end,
	},
}

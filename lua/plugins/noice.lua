return {
	"folke/noice.nvim",
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		{
			"rcarriga/nvim-notify",
			opts = {
				top_down = false,
				timeout = 3000,
				stages = "static",
			},
		},
	},
	event = "VeryLazy",
	opts = {
		cmdline = {
			view = "cmdline_popup",
		},
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				-- if needed add something for blink
				-- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
			hover = {
				silent = true,
			},
			progress = { enabled = false },
			signature = { enabled = false },
		},
		-- you can enable a preset for easier configuration
		presets = {
			-- command_palette = true,
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
		messages = {
			enabled = true,
			view = "mini",
		},
		notify = {
			enabled = true,
			view = "mini",
		},
		views = {},
		-- routes = {
		-- 	{
		-- 		filter = {
		-- 			event = "msg_show",
		-- 			kind = "",
		-- 			find = "written",
		-- 		},
		-- 		opts = { skip = true },
		-- 	},
		-- },
	},
}

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
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
			hover = {
				silent = true,
			},
			signature = {
				auto_open = {
					throttle = 50, -- Debounce lsp signature help request by 50ms
				},
			},
		},
		-- you can enable a preset for easier configuration
		presets = {
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
		messages = {
			enabled = true,
		},
		notify = {
			enabled = true,
		},
		views = {},
	},
}

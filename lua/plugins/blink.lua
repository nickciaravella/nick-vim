return {
	"saghen/blink.cmp",
	version = "*",
	opts = {
		cmdline = {
			enabled = true,
			sources = function()
				local type = vim.fn.getcmdtype()
				-- Search mode
				if type == "/" or type == "?" then
					return { "buffer" }
				end
				-- Command mode
				if type == ":" then
					return { "cmdline" }
				end
				return {}
			end,
		},
		completion = {
			menu = {
				draw = {
					columns = {
						{ "kind_icon" },
						{ "label" },
						{ "label_description" },
						{ "source_name" },
					},
				},
			},
			documentation = {
				-- Use ctrl-space to show it manually
				-- auto_show = true,
				-- auto_show_delay_ms = 200,
				window = { border = "rounded" },
			},
			ghost_text = {
				-- Not enabled since Copilot suggestions show as ghost text.
				-- They interfere with each other.
				enabled = false,
			},
		},
		signature = { enabled = true },
	},
}

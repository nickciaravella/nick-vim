return {
	"saghen/blink.cmp",
	version = "1.*",
	opts = {
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
		},
		signature = { enabled = true },
		sources = {
			providers = {
				buffer = {
					enabled = function()
						return not vim.tbl_contains({ "markdown", "text" }, vim.bo.filetype)
					end,
				},
			},
		},
	},
}

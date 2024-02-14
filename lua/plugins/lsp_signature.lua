return {
	"ray-x/lsp_signature.nvim",
	opts = {
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		handler_opts = {
			border = "rounded",
		},
		hint_enable = false,
	},
	config = function(_, opts)
		require("lsp_signature").setup(opts)
	end,
}

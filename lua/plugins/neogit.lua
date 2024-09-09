return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	event = "BufReadPost",
	config = function()
		local neogit = require("neogit")
		neogit.setup({
			kind = "vsplit",
			commit_editor = { kind = "vsplit" },
		})
		vim.keymap.set("n", "<leader>go", "<CMD>Neogit<CR>")
		vim.keymap.set("n", "<leader>gc", neogit.action("commit", "commit"))
		vim.keymap.set("n", "<leader>gC", neogit.action("commit", "commit", { "--verbose", "--all" }))
		vim.keymap.set("n", "<leader>gp", neogit.action("pull", "from_pushremote"))
		vim.keymap.set("n", "<leader>gP", neogit.action("push", "to_pushremote"))
		vim.keymap.set("n", "<leader>gz", neogit.action("stash", "pop"))
		vim.keymap.set("n", "<leader>gZ", neogit.action("stash", "push"))
	end,
}

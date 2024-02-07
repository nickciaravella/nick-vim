return {
	"github/copilot.vim",
	config = function()
		vim.g.copilot_assume_mapped = true
	end,
	keys = {
		{ "<leader>ce", "<CMD>Copilot enable<CR>" },
		{ "<leader>cd", "<CMD>Copilot disable<CR>" },
	},
}

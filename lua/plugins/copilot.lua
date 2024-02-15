return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	opts = {
		-- Disabling as they can interfere with copilot-cmp
		suggestion = { enabled = false },
		panel = { enabled = false },
	},
}

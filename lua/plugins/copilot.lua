return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	opts = {
		-- suggestion = { enabled = false },
		panel = { enabled = false },
		suggestion = {
			auto_trigger = true,
			hide_during_completion = false,
			keymap = {
				accept = "<C-;>", -- blink uses <C-y>
				accept_word = false,
				accept_line = false,
				next = "<C-j>", -- blink uses <C-n>
				prev = "<C-k>", -- blink uses <C-p>
				dismiss = "<C-]>",
			},
		},
		copilot_node_command = "/opt/homebrew/opt/node@22/bin/node",
	},
}

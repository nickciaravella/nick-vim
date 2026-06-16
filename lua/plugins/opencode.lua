return {
	"nickjvandyke/opencode.nvim",
	version = "*",
	dependencies = {
		"folke/snacks.nvim",
	},
	config = function()
		local opencode_cmd = "opencode --port"
		local terminal_opts = {
			win = {
				position = "float",
				width = 0.95,
				height = 0.95,
				enter = true,
			},
		}

		vim.g.opencode_opts = {
			server = {
				start = function()
					require("snacks").terminal.open(opencode_cmd, terminal_opts)
				end,
			},
		}

		vim.keymap.set({ "n", "x" }, "<leader>oa", function()
			require("opencode").ask("@this: ")
		end, { desc = "Ask OpenCode" })

		vim.keymap.set({ "n", "x" }, "<leader>os", function()
			require("opencode").select()
		end, { desc = "Select OpenCode" })

		vim.keymap.set("n", "<leader>oo", function()
			require("snacks").terminal.toggle(opencode_cmd, terminal_opts)
		end, { desc = "Open OpenCode" })

		vim.keymap.set({ "n", "t" }, "<C-.>", function()
			require("snacks").terminal.toggle(opencode_cmd, terminal_opts)
		end, { desc = "Toggle OpenCode" })
	end,
}

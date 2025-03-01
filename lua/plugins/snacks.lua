return {
	"folke/snacks.nvim",
	lazy = false,
	keys = {
		{
			"<leader>ff",
			function()
				require("snacks").picker.files()
			end,
		},
		{
			"<leader>fb",
			function()
				require("snacks").picker.buffers()
			end,
		},
		{
			"<leader>fc",
			function()
				require("snacks").picker.command_history()
			end,
		},
		{
			"-",
			function()
				require("snacks").explorer()
			end,
		},
		-- git
		{
			"<leader>gs",
			function()
				require("snacks").picker.git_status()
			end,
		},
		{
			"<leader>gc",
			function()
				require("snacks").picker.git_branches()
			end,
		},
		-- Grep
		{
			"<leader>sb",
			function()
				require("snacks").picker.lines()
			end,
		},
		{
			"<leader>sB",
			function()
				require("snacks").picker.grep_buffers()
			end,
		},
		{
			"<leader>st",
			function()
				require("snacks").picker.grep()
			end,
		},
		{
			"<leader>sw",
			function()
				require("snacks").picker.grep_word()
			end,
			mode = { "n", "x" },
		},
		{
			"<leader>fd",
			function()
				require("snacks").picker.diagnostics()
			end,
		},
		{
			"<leader>fh",
			function()
				require("snacks").picker.help()
			end,
		},
		{
			"<leader>sR",
			function()
				require("snacks").picker.resume()
			end,
		},
		-- LSP
		{
			"gd",
			function()
				require("snacks").picker.lsp_definitions()
			end,
		},
		{
			"gr",
			function()
				require("snacks").picker.lsp_references()
			end,
			nowait = true,
		},
	},
	opts = {
		dashboard = {
			preset = {
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "e", desc = "Explorer", action = ":lua Snacks.dashboard.pick('explorer')" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1 },
			},
		},
		explorer = {},
		picker = {
			sources = {
				buffers = {
					layout = {
						preset = "select",
					},
				},
				command_history = {
					layout = {
						preset = "select",
					},
				},
				explorer = {
					laout = {
						preset = "sidebar",
						preview = true,
					},
					-- focus = "input",
					auto_close = true,
				},
				files = {
					layout = {
						preset = "select",
					},
				},
				git_branches = {
					layout = {
						preset = "select",
					},
				},
				recent = {
					layout = {
						preset = "select",
					},
				},
			},
			layout = {
				preset = "ivy",
			},
			matcher = {
				frecency = true,
			},
			formatters = {
				file = {
					filename_first = true,
				},
			},
		},
	},
}

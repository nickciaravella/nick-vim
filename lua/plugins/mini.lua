return {
	{
		"echasnovski/mini.surround",
		version = "*",
		config = function()
			require("mini.surround").setup()
		end,
	},
	{
		"echasnovski/mini.pairs",
		version = "*",
		config = function()
			require("mini.pairs").setup()
		end,
	},
	{
		"echasnovski/mini.comment",
		version = "*",
		config = function()
			require("mini.comment").setup()
		end,
	},
	{
		"echasnovski/mini.starter",
		version = "*",
		config = function()
			local go_to_project = function(path)
				return function()
					vim.api.nvim_set_current_dir(path)
					require("telescope.builtin").find_files()
				end
			end
			require("mini.starter").setup({
				evaluate_single = true,
				header = table.concat({
					[[  /\ \ \___  ___/\   /( )_ __ ___  ]],
					[[ /  \/ / _ \/ _ \ \ / / | '_ ` _ \ ]],
					[[/ /\  /  __/ (_) \ V /| | | | | | |]],
					[[\_\ \/ \___|\___/ \_/ |_|_| |_| |_|]],
					-- [[───────────────────────────────────]],
					[[]],
					[[]],
				}, "\n"),
				footer = "",
				items = {
					{ section = "Projects", name = "server (theboss)", action = go_to_project("~/src/theboss/server") },
					{ section = "Projects", name = "client (theboss)", action = go_to_project("~/src/theboss/client") },
					{ section = "Projects", name = "blackwell", action = go_to_project("~/src/blackwell") },
					{ section = "Config", name = "Neovim", action = go_to_project("~/.config/nvim") },
					{ section = "Config", name = "Wezterm", action = go_to_project("~/.config/wezterm") },
				},
			})
		end,
	},
}

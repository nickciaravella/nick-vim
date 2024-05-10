return {
	"nvim-telescope/telescope.nvim",
	lazy = false,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		{
			"ahmedkhalf/project.nvim",
			opts = {
				active = true,
				on_config_done = nil,
				manual_mode = false,
				detection_methods = { "pattern" },
				patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
				show_hidden = false,
				silent_chdir = true,
				ignore_lsp = {},
				datapath = vim.fn.stdpath("data"),
			},
			config = function(_, opts)
				require("project_nvim").setup(opts)
			end,
		},
		{
			"Myzel394/jsonfly.nvim",
		},
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				layout_strategy = "vertical",
				layout_config = {
					vertical = {
						prompt_position = "top",
						mirror = true,
						width = 0.9,
						height = 0.9,
						preview_cutoff = 1,
					},
				},
				prompt_prefix = " ",
				selection_caret = " ",
				path_display = { "smart" },

				mappings = {
					i = {
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,

						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,

						["<C-c>"] = actions.close,

						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,

						["<CR>"] = actions.select_default,
						["<C-x>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						["<C-t>"] = actions.select_tab,

						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,

						["<PageUp>"] = actions.results_scrolling_up,
						["<PageDown>"] = actions.results_scrolling_down,

						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-l>"] = actions.complete_tag,
						["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
					},
					n = {
						["<esc>"] = actions.close,
						["<CR>"] = actions.select_default,
						["<C-x>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						["<C-t>"] = actions.select_tab,

						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

						["j"] = actions.move_selection_next,
						["k"] = actions.move_selection_previous,
						["H"] = actions.move_to_top,
						["M"] = actions.move_to_middle,
						["L"] = actions.move_to_bottom,

						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,
						["gg"] = actions.move_to_top,
						["G"] = actions.move_to_bottom,

						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,

						["<PageUp>"] = actions.results_scrolling_up,
						["<PageDown>"] = actions.results_scrolling_down,

						["?"] = actions.which_key,
					},
				},
			},
			pickers = {
				find_files = {
					theme = "dropdown",
					previewer = false,
				},
				oldfiles = {
					theme = "dropdown",
					previewer = false,
				},
				buffers = {
					theme = "dropdown",
					previewer = false,
				},
				git_files = {
					theme = "dropdown",
					previewer = false,
				},
				current_buffer_fuzzy_find = {
					theme = "dropdown",
					previewer = false,
				},
				planets = {
					show_pluto = true,
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- "ignore_case", "respect_case" or "smart_case"
				},
			},
		})

		telescope.load_extension("aerial")
		telescope.load_extension("projects")
		telescope.load_extension("fzf")
		telescope.load_extension("jsonfly")

		-- Set keymaps

		-- Find XXX
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[F]ind [R]ecently opened files" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind existing [B]uffers" })
		vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "[F]ind [G]it files" })

		-- Search XXX
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>sc", builtin.current_buffer_fuzzy_find, { desc = "[S]earch in [C]urrent buffer" })
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })

		-- Go to XXX (note - no leader. Overriding LSP keymaps)
		vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "[G]o to [D]efinition" })
		vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "[G]o to [R]eferences" })
		vim.keymap.set("n", "gs", builtin.lsp_document_symbols, { desc = "[G]o to [S]ymbols" })
		vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "[G]o to [I]mplementations" })
		vim.keymap.set("n", "gt", builtin.lsp_type_definitions, { desc = "[G]o to [T]ype Defintion" })
		vim.keymap.set("n", "go", "<CMD>Telescope aerial<CR>", { desc = "[G]o to [O]utline" })

		-- Diagnostics
		vim.keymap.set("n", "<leader>dl", require("telescope.builtin").diagnostics, { desc = "[D]iagnostics [L]ist" })
	end,
}

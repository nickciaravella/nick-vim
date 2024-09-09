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
			"Myzel394/jsonfly.nvim",
		},
		{
			"ahmedkhalf/project.nvim",
			config = function()
				require("project_nvim").setup({
					detection_methods = { "pattern" },
					patterns = {
						"package.json",
					},
					exclude_dirs = { "/opt/homebrew", "~/*/node_modules/*", "~/*/prisma/generated/*" },
				})
			end,
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
				path_display = { "filename_first" },
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
		telescope.load_extension("fzf")
		telescope.load_extension("jsonfly")
		telescope.load_extension("projects")
		telescope.load_extension("notify")

		-- Set keymaps

		-- Find XXX
		vim.keymap.set("n", "<leader>ff", builtin.find_files)
		vim.keymap.set("n", "<leader>fb", builtin.buffers)
		vim.keymap.set("n", "<leader>fp", "<CMD>Telescope projects<CR>")
		vim.keymap.set("n", "<leader>fs", function()
			builtin.lsp_dynamic_workspace_symbols({ symbols = { "class", "function", "method" } })
		end)
		vim.keymap.set("n", "<leader>ft", builtin.live_grep)
		vim.keymap.set("v", "<leader>fw", "y<ESC>:Telescope live_grep default_text=<c-r>0<CR>") -- Find currenlty highlighted word
		vim.keymap.set("n", "<leader>fw", "yiw<ESC>:Telescope live_grep default_text=<c-r>0<CR>") -- Find word under cursor

		vim.keymap.set("n", "<leader>fr", builtin.resume)
		vim.keymap.set("n", "<leader>fh", builtin.help_tags)
		vim.keymap.set("n", "<leader>fk", builtin.keymaps)
		vim.keymap.set("n", "<leader>fm", "<CMD>Telescope notify<CR>")

		-- Go to XXX (note - no leader. Overriding LSP keymaps)
		vim.keymap.set("n", "gd", builtin.lsp_definitions)
		vim.keymap.set("n", "gr", builtin.lsp_references)
		vim.keymap.set("n", "gs", builtin.lsp_document_symbols)
		vim.keymap.set("n", "gi", builtin.lsp_implementations)
		vim.keymap.set("n", "gt", builtin.lsp_type_definitions)
	end,
}

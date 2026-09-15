local indent_guides_enabled = true
local indent_scope_enabled = true

local function refresh_indent()
	local snacks = require("snacks")

	if snacks.indent.enabled then
		snacks.indent.disable()
	end

	snacks.config.indent.scope.enabled = indent_scope_enabled

	if indent_guides_enabled then
		snacks.indent.enable()
	end
end

-- The select preset keeps the preview hidden from the layout. Open the main-window preview only
-- while there is a current item, so the layout never paints an empty float over the editor.
local function show_main_preview_for_current_item(picker)
	if not picker.preview.main then
		return
	end
	local win = picker.preview.win
	if picker:current() and not win:valid() then
		win:show()
	elseif not picker:current() and win:valid() then
		win:hide()
	end
end

return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	keys = {
		{
			"<leader>e",
			function()
				require("snacks").explorer()
			end,
			desc = "Open Explorer to Current File",
		},
		{
			"-",
			function()
				require("snacks").explorer()
			end,
			desc = "Open Explorer to Current File",
		},
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
			"gA",
			function()
				require("snacks").picker.lsp_references()
			end,
			nowait = true,
		},
		{
			"<leader>bl",
			function()
				indent_guides_enabled = not indent_guides_enabled
				refresh_indent()
				vim.notify("Indent guides " .. (indent_guides_enabled and "enabled" or "disabled"))
			end,
			desc = "Toggle Indent Guides",
		},
		{
			"<leader>bs",
			function()
				indent_scope_enabled = not indent_scope_enabled
				refresh_indent()
				vim.notify("Indent scope " .. (indent_scope_enabled and "enabled" or "disabled"))
			end,
			desc = "Toggle Indent Scope",
		},
	},
	opts = {
		explorer = {},
		input = {},
		indent = {
			indent = {
				char = "▏",
			},
			scope = {
				hl = { "Function", "Label" },
			},
			animate = {
				enabled = false,
			},
		},
		picker = {
			sources = {
				buffers = {
					layout = {
						preset = "select_top",
					},
				},
				command_history = {
					layout = {
						preset = "select",
					},
				},
				files = {
					layout = {
						preset = "select_top",
					},
				},
				git_branches = {
					layout = {
						preset = "select_top",
					},
				},
				grep = {
					layout = {
						preset = "select_top_main",
					},
					on_change = show_main_preview_for_current_item,
				},
				grep_word = {
					layout = {
						preset = "select_top_main",
					},
					on_change = show_main_preview_for_current_item,
				},
			},
			layouts = {
				select_top = {
					preset = "select",
					layout = {
						row = 1,
						width = 0.4,
						title = "{title} {live} {flags}",
					},
				},
				select_top_main = {
					preset = "select_top",
					preview = "main",
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
		dashboard = {
			preset = {
				header = [[██████╗ █████╗ ██████╗ ██╗████████╗ █████╗ ██╗      ██████╗ ███████╗
██╔════╝██╔══██╗██╔══██╗██║╚══██╔══╝██╔══██╗██║     ██╔═══██╗██╔════╝
██║     ███████║██████╔╝██║   ██║   ███████║██║     ██║   ██║███████╗
██║     ██╔══██║██╔═══╝ ██║   ██║   ██╔══██║██║     ██║   ██║╚════██║
╚██████╗██║  ██║██║     ██║   ██║   ██║  ██║███████╗╚██████╔╝███████║
╚═════╝╚═╝  ╚═╝╚═╝     ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚══════╝]],
			},
			sections = {
				{ section = "header" },
				{
					icon = " ",
					title = "Projects",
					section = "projects",
					limit = 6,
					indent = 2,
					padding = 1,
					dirs = {
						"~/src/theboss/server",
						"~/src/theboss/client",
						"~/src/theboss/packages",
						"~/my/homepage-api",
						"~/my/homepage-web",
						"~/.config/nvim",
					},
				},
				{
					icon = " ",
					title = "Recent Files",
					section = "recent_files",
					limit = 10,
					indent = 2,
					padding = 3,
				},
				{ section = "startup" },
			},
		},
	},
}

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

-- Header rows are centered one at a time and the save autocmd strips trailing spaces, so build
-- the padding here: every row gets the same width, and the middle row gets the stripe.
local function striped_header(lines, stripe)
	local width = 0
	for _, line in ipairs(lines) do
		width = math.max(width, vim.api.nvim_strwidth(line))
	end
	local margin = string.rep(" ", vim.api.nvim_strwidth(stripe) + 1)
	for i, line in ipairs(lines) do
		local pad = string.rep(" ", width - vim.api.nvim_strwidth(line))
		if i == math.ceil(#lines / 2) then
			lines[i] = stripe .. " " .. line .. pad .. " " .. stripe
		else
			lines[i] = margin .. line .. pad .. margin
		end
	end
	return table.concat(lines, "\n")
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
			width = 44,
			preset = {
				header = striped_header({
					"███████╗████████╗██████╗ ██╗██████╗ ███████╗",
					"██╔════╝╚══██╔══╝██╔══██╗██║██╔══██╗██╔════╝",
					"███████╗   ██║   ██████╔╝██║██████╔╝█████╗",
					"╚════██║   ██║   ██╔══██╗██║██╔═══╝ ██╔══╝",
					"███████║   ██║   ██║  ██║██║██║     ███████╗",
					"╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝     ╚══════╝",
				}, string.rep("═", 10)),
				keys = {
					{ icon = " ", key = "f", desc = "Find file", action = "<leader>ff" },
					{ icon = " ", key = "t", desc = "Search text", action = "<leader>st" },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "header", padding = 1 },
				function()
					return { footer = vim.fn.fnamemodify(vim.fn.getcwd(), ":~"), padding = 2 }
				end,
				{ section = "keys", gap = 1 },
			},
		},
	},
}

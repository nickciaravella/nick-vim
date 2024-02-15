return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("luasnip/loaders/from_vscode").lazy_load()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "BufRead",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"ray-x/cmp-treesitter",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"zbirenbaum/copilot-cmp",
			-- More sources can be found here: https://github.com/topics/nvim-cmp
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("copilot_cmp").setup()

			local check_backspace = function()
				local col = vim.fn.col(".") - 1
				return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
			end

			local kind_icons = {
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = " ",
				Variable = "󰀫",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "",
				Event = "",
				Operator = "󰆕",
				TypeParameter = " ",
				Misc = " ",

				-- Treesitter
				String = "",
				KeywordFunction = "󰌋",
				Comment = "󰉿",

				-- Copilot
				Copilot = "󰚩",
			}
			-- find more here: https://www.nerdfonts.com/cheat-sheet

			cmp.setup({
				enabled = function()
					local context = require("cmp.config.context")
					local buftype = vim.api.nvim_buf_get_option(0, "buftype")

					local disable = context.in_treesitter_capture("comment")
					disable = disable or context.in_treesitter_capture("string_content")
					disable = disable or buftype == "prompt"

					return not disable
				end,
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				mapping = {
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
					["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
					["<C-e>"] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
					-- Accept currently selected item. If none selected, `select` first item.
					-- Set `select` to `false` to only confirm explicitly selected items.
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if luasnip.expandable() then
							luasnip.expand()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif check_backspace() then
							fallback()
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						if not kind_icons[vim_item.kind] then
							vim.notify("No icon for " .. vim_item.kind)
						end

						vim_item.kind = string.format("%s", kind_icons[vim_item.kind] or "") .. " "
						vim_item.menu = entry.source.name

						if vim_item.menu == "treesitter" and vim_item.kind == "" then
							vim_item.kind = ""
						end

						return vim_item
					end,
				},
				sources = {
					-- The order here is the order that autocompletions show up.
					{ name = "copilot", max_item_count = 2 },
					{ name = "luasnip" },
					{
						name = "nvim_lsp",
						-- entry_filter = function(entry, context)
						-- 	local line = context.cursor_line
						-- 	local col = context.cursor_col
						-- 	local char_before_cursor = string.sub(line, col - 1, col - 1)
						-- 	if char_before_cursor == "," then
						-- 		return false
						-- 	end
						-- 	return true
						-- end,
					},
					{ name = "treesitter" },
					{ name = "path" },
					{ name = "buffer" },
				},
				confirm_opts = {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				},
				window = {
					documentation = {
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
					},
				},
				experimental = {
					ghost_text = true,
					native_menu = false,
				},
			})
		end,
	},
}

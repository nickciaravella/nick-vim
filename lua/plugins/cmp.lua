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
		event = { "InsertEnter", "CmdlineEnter" },
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
				Copilot = "",
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
					["<C-p>"] = cmp.mapping(function(fallback)
						cmp.complete({
							config = {
								sources = {
									{ name = "copilot" },
								},
							},
						})
					end, { "i", "c" }),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						if not kind_icons[vim_item.kind] then
							-- vim.notify("No icon for " .. vim_item.kind)
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
					-- { name = "copilot" },
					-- { name = "luasnip" },
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

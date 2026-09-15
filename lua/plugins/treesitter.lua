local parsers = {
	"bash",
	"css",
	"csv",
	"dockerfile",
	"gitcommit",
	"gitignore",
	"html",
	"javascript",
	"json",
	"lua",
	"make",
	"markdown",
	"markdown_inline",
	"prisma",
	"python",
	"regex",
	"styled",
	"sql",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"xml",
	"yaml",
}

local select_textobjects = {
	["aa"] = "@parameter.outer",
	["ia"] = "@parameter.inner",
	["af"] = "@function.outer",
	["if"] = "@function.inner",
	["ac"] = "@class.outer",
	["ic"] = "@class.inner",
}

local move_textobjects = {
	goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer", ["]a"] = "@parameter.outer" },
	goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer", ["]A"] = "@parameter.outer" },
	goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer", ["[a"] = "@parameter.outer" },
	goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer", ["[A"] = "@parameter.outer" },
}

local function attach(args)
	local buf, ft = args.buf, args.match
	local lang = vim.treesitter.language.get_lang(ft)
	if not lang or not vim.treesitter.language.add(lang) then
		return
	end

	for lhs, capture in pairs(select_textobjects) do
		vim.keymap.set({ "x", "o" }, lhs, function()
			require("nvim-treesitter-textobjects.select").select_textobject(capture, "textobjects")
		end, { buffer = buf, desc = "Select " .. capture })
	end
	for method, maps in pairs(move_textobjects) do
		for lhs, capture in pairs(maps) do
			vim.keymap.set({ "n", "x", "o" }, lhs, function()
				require("nvim-treesitter-textobjects.move")[method](capture, "textobjects")
			end, { buffer = buf, desc = method .. " " .. capture })
		end
	end

	-- Neovim's builtin `an`/`in` call this module, but mini.ai owns those keys.
	vim.keymap.set({ "n", "x" }, "<CR>", function()
		require("vim.treesitter._select").select_parent(vim.v.count1)
	end, { buffer = buf, desc = "Select node, then parent node" })
	vim.keymap.set("x", "N", function()
		require("vim.treesitter._select").select_child(vim.v.count1)
	end, { buffer = buf, desc = "Select child node" })

	if ft == "css" then
		return
	end
	if vim.api.nvim_buf_line_count(buf) > 2000 then
		vim.notify("Disabling Treesitter for large file", vim.log.levels.INFO, { title = "Treesitter" })
		return
	end
	vim.treesitter.start(buf, lang)
	if ft ~= "python" then
		vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install(parsers)
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter-attach", { clear = true }),
				callback = attach,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		lazy = false,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = { select = { lookahead = true } },
	},
}

local servers = {
	"cssls", -- CSS
	"gopls", -- Go
	"eslint", -- ESLint
	"html", -- HTML
	"jedi_language_server", -- Python
	"jsonls", -- JSON
	"lua_ls", -- Lua
	"prismals", -- Prisma Schema files.
	"tailwindcss", -- Tailwind CSS
	"ts_ls", -- Typescript/JavaScript
	-- "tsgo",                 -- Typescript, Go server - not ready for prime time yet.
	"yamlls", -- YAML
}

-- Show the floating window after [d / ]d jump to a diagnostic.
vim.diagnostic.config({
	jump = {
		-- config() replaces the whole `jump` table, so the wrap default must be restated
		wrap = true,
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
		end,
	},
})

-- Read-only typings get nothing from these servers, and large ones slow the editor down.
local function skip_declaration_files(server)
	local root_dir = vim.lsp.config[server].root_dir
	vim.lsp.config(server, {
		root_dir = function(bufnr, on_dir)
			if not vim.api.nvim_buf_get_name(bufnr):find("%.d%.ts$") then
				root_dir(bufnr, on_dir)
			end
		end,
	})
end

return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason").setup()
			skip_declaration_files("eslint")
			skip_declaration_files("tailwindcss")
			require("mason-lspconfig").setup({
				ensure_installed = servers,
				automatic_enable = servers,
			})

			-- add support for tools (mason-tool-installer), next time i need to
			-- install prettierd or something

			-- mason-lspconfig setups up lsp servers with defaults
			-- and enables them. For extra customization, put additional
			-- configuration into after/lsp/<server>.lua files.
		end,
	},
}

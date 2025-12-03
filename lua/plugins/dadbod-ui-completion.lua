return {
	"kristijanhusak/vim-dadbod-completion",
	lazy = true,
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"sql",
				"mysql",
				"plsql",
			},
			callback = function()
				-- see if blink supports db completion if i ever use this again
				-- vim.schedule(db_completion)
			end,
		})
	end,
}

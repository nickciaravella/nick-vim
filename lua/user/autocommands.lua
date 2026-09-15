-- Trim trailing whitespace when saving a file.
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		pcall(function()
			vim.cmd([[%s/\s\+$//e]])
		end)
		vim.fn.setpos(".", save_cursor)
	end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

-- Automatically enter insert mode when entering a terminal buffer`
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
	pattern = { "*" },
	callback = function()
		if vim.opt.buftype:get() == "terminal" then
			vim.cmd(":startinsert")
		end
	end,
})

-- ftplugins add these back after the global option is set, so strip them per buffer.
vim.api.nvim_create_autocmd("FileType", {
	desc = "Don't auto-insert comment leaders on wrap, <Enter>, o, or O",
	group = vim.api.nvim_create_augroup("formatoptions", { clear = true }),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

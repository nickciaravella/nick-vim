return {
	"kevinhwang91/nvim-hlslens",
	config = function()
		require("hlslens").setup({
			calm_down = true,
			override_lens = function(render, posList, nearest, idx, relIdx)
				local cnt = #posList
				local text = ("(%d/%d)"):format(idx, cnt)
				if not nearest then
					local letter = (relIdx > 0 and "n" or "N")
					local number = math.abs(relIdx) ~= 1 and tostring(math.abs(relIdx)) or ""
					text = ("%s%s "):format(number, letter)
				end
				local higlight = nearest and "HlSearchLensNear" or "HlSearchLens"
				local chunks = { { " ", "Ignore" }, { text, higlight } }
				local lnum, col = unpack(posList[idx])
				render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
			end,
		})

		vim.api.nvim_set_hl(0, "HlSearchLensNear", { link = "WildMenu" })
		vim.api.nvim_set_hl(0, "HlSearchLens", { link = "LineNr" })

		local kopts = { noremap = true, silent = true }

		vim.api.nvim_set_keymap(
			"n",
			"n",
			[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
			kopts
		)
		vim.api.nvim_set_keymap(
			"n",
			"N",
			[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
			kopts
		)
		vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
		vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
		vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
		vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
	end,
}

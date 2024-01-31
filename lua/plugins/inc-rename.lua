return {
    "smjonas/inc-rename.nvim",
    config = function()
        require("inc_rename").setup({
            rmd_name = "IncRename",
            hl_group = "Substitute",
            preview_empty_name = false,
            show_message = true,
            input_buffer_type = nil,
            post_hook = nil,
        })
    end,
    cmd = { 'IncRename' },
    keys = {
        {
            '<leader>rr',
            function() return ":IncRename " .. vim.fn.expand("<cword>") end,
            expr = true,
            desc = "[R]efactor [R]ename"
        },
    },
}

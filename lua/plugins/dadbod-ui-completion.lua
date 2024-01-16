local function db_completion()
  require("cmp").setup.buffer { sources = { { name = "vim-dadbod-completion" } } }
end

return {
    'kristijanhusak/vim-dadbod-completion',
    lazy = true,
    config = function ()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "sql",
                "mysql",
                "plsql",
            },
            callback = function()
                vim.schedule(db_completion)
            end,
        })
    end
}


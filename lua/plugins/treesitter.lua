return {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    build = ":TSUpdate",
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = function ()
        local configs = require "nvim-treesitter.configs"
        configs.setup {
            ensure_installed = {
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
            },
            ignore_install = { "" },
            sync_install = false,
            highlight = {
                enable = true,
                disable = { "css" },
            },
            indent = { enable = true, disable = { "python", "css" } },
        }
    end
}

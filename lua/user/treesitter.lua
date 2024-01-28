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
    }, -- put the language you want in this array
    -- ensure_installed = "all", -- one of "all" or a list of languages
    ignore_install = { "" },                                                       -- List of parsers to ignore installing
    sync_install = false,                                                          -- install languages synchronously (only applied to `ensure_installed`)

    highlight = {
      enable = true,       -- false will disable the whole extension
      disable = { "css" }, -- list of language that will be disabled
    },
    autopairs = {
      enable = true,
    },
    indent = { enable = true, disable = { "python", "css" } },
}

require('ts_context_commentstring').setup {
    enable_autocmd = false,
}


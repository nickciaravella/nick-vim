return {
    -- LSP
    {
        "neovim/nvim-lspconfig",
        config = function() require('user/lsp/lspconfig') end
    },
    {
        "williamboman/mason.nvim",                                              -- simple to use language server installer
        config = function() require('user/lsp/mason') end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        config = function() require('user/lsp/mason-lspconfig') end
    },
    {
        "jose-elias-alvarez/null-ls.nvim",                                      -- for formatters and linters
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        config = function() require('user/null-ls') end
    },
}


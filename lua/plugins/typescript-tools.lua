return {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
        require("typescript-tools").setup({
            on_attach = require("user.lsp.lsp-shared").on_attach,
            capabilities = require("user.lsp.lsp-shared").capabilities,

        })
    end,
}

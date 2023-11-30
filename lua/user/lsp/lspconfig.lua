local lspconfig = require('lspconfig')

local opts = {}

for _, server in pairs(require("user.lsp.servers")) do
    opts = {
        on_attach = require("user.lsp.lsp-shared").on_attach,
        capabilities = require("user.lsp.lsp-shared").capabilities,
    }

    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
    if require_ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    lspconfig[server].setup(opts)
end


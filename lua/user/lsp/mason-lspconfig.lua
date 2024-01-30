local mason_lspconfig = require("mason-lspconfig")
local shared = require("user.lsp.lsp-shared")

local mason_servers = table.insert(shared.servers, 'tsserver')
local settings = {
    ensure_installed = mason_servers,
    automatic_installation = true,
}

mason_lspconfig.setup(settings)


local mason_lspconfig = require("mason-lspconfig")
local shared = require("user.lsp.lsp-shared")

local settings = {
    ensure_installed = shared.servers,
    automatic_installation = true,
}

mason_lspconfig.setup(settings)


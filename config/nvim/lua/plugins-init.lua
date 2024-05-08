require("neoconf").setup()
require("neodev").setup({
    library = {
        enabled = true,
        runtime = true,
        types = true,
        plugins = true
    },
    setup_jsonls = true,
    lspconfig = true,
    pathStrict = true
})
require("fidget-config")
require("mason").setup()
require("mason-lspconfig").setup()
require("lsp-config")
-- separate LSP config for Rust
require("rust-config")

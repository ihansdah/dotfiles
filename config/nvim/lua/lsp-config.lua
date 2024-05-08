local on_attach = require("lsp-keybindings").on_attach

local merge = function(a, b)
    local c = {}
    for k, v in pairs(a) do
        c[k] = v
    end
    for k, v in pairs(b) do
        c[k] = v
    end
    return c
end

-- boilerplate to make it work
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- common to all LSPs
local common_setup = {
    on_attach = on_attach,
    capabilities = capabilities,
    -- handlers = handlers,
    flags = {
        debounce_text_changes = 150,
    },
}

-- for all except rust
local lsps = {
    "gopls",
    "pyright",
    "clangd",
    "html",
    "cssls",
    "tsserver",
    hls = {
        settings = {
            haskell = { formattingProvider = "fourmolu" },
        },
    },
    jsonls = { cmd = { "vscode-json-languageserver", "--stdio" } },
    lua_ls = {
        settings = {
            Lua = {
                workspace = {
                    preloadFileSize = 100,
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    },
}

local nvim_lsp = require("lspconfig")
for k, v in pairs(lsps) do
    if type(v) == "string" then
        nvim_lsp[v].setup(common_setup)
    else
        nvim_lsp[k].setup(merge(common_setup, v))
    end
end

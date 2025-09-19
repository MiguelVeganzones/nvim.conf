vim.lsp.config("basedpyright", {
    cmd = { vim.fn.expand("~/.venvs/nvim/bin/basedpyright-langserver"), "--stdio" },
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    settings = {
        basedpyright = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic", -- or "standard" / "strict"
            },
        },
    },
})

vim.lsp.enable("basedpyright")

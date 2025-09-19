vim.lsp.config("clangd", {
  cmd = { "clangd", "--background-index", "--cross-file-rename" },
})
vim.lsp.enable("clangd")

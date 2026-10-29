vim.lsp.config("clangd", {
  cmd = { "clangd", "--background-index" },
})
vim.lsp.enable("clangd")

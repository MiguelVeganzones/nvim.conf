vim.g.mkdp_filetypes = { "markdown" }

vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown preview toggle" })
vim.keymap.set("n", "<leader>ms", "<cmd>MarkdownPreview<cr>", { desc = "Markdown preview start" })
vim.keymap.set("n", "<leader>mx", "<cmd>MarkdownPreviewStop<cr>", { desc = "Markdown preview stop" })

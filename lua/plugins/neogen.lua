require("neogen").setup {}

vim.keymap.set("n", "<Leader>nf", function()
    require("neogen").generate({ type = "func" })
end, { desc = "Neogen: generate function annotation", noremap = true, silent = true })

vim.keymap.set("n", "<Leader>nc", function()
    require("neogen").generate({ type = "class" })
end, { desc = "Neogen: generate class annotation", noremap = true, silent = true })

vim.keymap.set("n", "<Leader>nt", function()
    require("neogen").generate({ type = "type" })
end, { desc = "Neogen: generate type annotation", noremap = true, silent = true })

vim.keymap.set("n", "<Leader>nF", function()
    require("neogen").generate({ type = "file" })
end, { desc = "Neogen: generate file annotation", noremap = true, silent = true })

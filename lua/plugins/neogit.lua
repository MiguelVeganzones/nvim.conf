require("neogit").setup({})

vim.keymap.set("n", "<leader>gg", function()
  require("neogit").open()
end, {
  desc = "Show Neogit UI",
})

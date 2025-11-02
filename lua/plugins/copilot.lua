local function toggle_copilot()
    if vim.g.copilot_enabled then
        vim.cmd('Copilot disable')
        vim.g.copilot_enabled = false
        print("Copilot disabled")
    else
        vim.cmd('Copilot enable')
        vim.g.copilot_enabled = true
        print("Copilot enabled")
    end
end

vim.keymap.set('i', '<C-y>', 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false
})
vim.keymap.set('i', '<C-n>', '<Plug>(copilot-next)', { desc = 'Next suggestion' })
vim.keymap.set('i', '<C-p>', '<Plug>(copilot-previous)', { desc = 'Previous suggestion' })
vim.keymap.set('n', '<leader>ct', toggle_copilot, { desc = 'Toggle Copilot' })
vim.g.copilot_no_tab_map = true
vim.g.copilot_enabled = false

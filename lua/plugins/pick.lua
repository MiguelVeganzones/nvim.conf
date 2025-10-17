vim.keymap.set("n", "<Leader>sb", function() MiniPick.builtin.buffers() end, { desc = "Find buffers" })

vim.keymap.set("n", "<Leader>sh", function() MiniPick.builtin.help() end, { desc = "Find help" })

vim.keymap.set("n", "<Leader>sn", function()
    local cwd = vim.fn.stdpath("config")
    MiniPick.builtin.cli({
        command = { "fd", "--type", "f", ".", "--hidden" },
    }, {
        source = {
            name = "Neovim config files",
            cwd = cwd,
        },
    })
end, { desc = "Find in Neovim config" })


if vim.fn.has("win32") == 1 then
    vim.env.RIPGREP_CONFIG_PATH = vim.fn.expand("~/AppData/Local/ripgrep/config")
else
    vim.env.RIPGREP_CONFIG_PATH = vim.fn.expand("~/.config/ripgrep/config")
end
vim.keymap.set("n", "<Leader>sg", function()
    MiniPick.builtin.grep_live({ tool = 'rg' })
end, { desc = "Live content search (grep)" })

vim.keymap.set("n", "<Leader>sr", function()
    MiniPick.builtin.cli({ command = { 'git', 'ls-files' } })
end, { desc = "Find in git repo" })

vim.keymap.set("n", "<leader>sf", function()
    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    local search_dir = vim.v.shell_error == 0 and git_root or vim.loop.cwd()

    MiniPick.builtin.cli({
        command = {
            "fd",
            "--type", "f",
            "--exclude", "*.o",
            "--exclude", "*.out",
            "--exclude", "*.a",
        },
    }, {
        cwd = search_dir,
        source = { name = "Filtered files" },
    })
end, { desc = "Find files (filtered)" })

vim.keymap.set("n", "<leader>sa", function()
    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    local search_dir = vim.v.shell_error == 0 and git_root or vim.loop.cwd()

    MiniPick.builtin.cli({
        command = {
            "fd",
            "--type", "f",
            "--hidden",
        },
    }, {
        cwd = search_dir,
        source = { name = "Filtered files" },
    })
end, { desc = "Find files (filtered)" })

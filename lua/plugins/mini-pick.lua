require("mini.pick").setup()

local function project_root()
    return vim.fs.root(vim.uv.cwd(), ".git") or vim.uv.cwd()
end

local function find_files(name, cwd, command)
    MiniPick.builtin.cli({ command = command }, { source = { name = name, cwd = cwd } })
end

vim.keymap.set("n", "<Leader>sb", function() MiniPick.builtin.buffers() end, { desc = "Find buffers" })

vim.keymap.set("n", "<Leader>sh", function() MiniPick.builtin.help() end, { desc = "Find help" })

vim.keymap.set("n", "<Leader>sn", function()
    find_files("Neovim config files", vim.fn.stdpath("config"), { "fd", "--type", "f", "--hidden" })
end, { desc = "Find in Neovim config" })

vim.env.RIPGREP_CONFIG_PATH = vim.fn.expand(vim.fn.has("win32") == 1
    and "~/AppData/Local/ripgrep/config" or "~/.config/ripgrep/config")
vim.keymap.set("n", "<Leader>sG", function()
    MiniPick.builtin.grep_live({ tool = "rg" })
end, { desc = "Live content search (grep)" })

vim.keymap.set("n", "<Leader>sg", function()
    MiniPick.builtin.grep_live({ tool = "rg", globs = { "!*test*/" } })
end, { desc = "Live content search (grep), skip test dirs" })

vim.keymap.set("n", "<Leader>sr", function()
    MiniPick.builtin.cli({ command = { "git", "ls-files" } })
end, { desc = "Find in git repo" })

vim.keymap.set("n", "<Leader>sF", function()
    find_files("Filtered files", project_root(),
        { "fd", "--type", "f", "--exclude", "*.o", "--exclude", "*.out", "--exclude", "*.a" })
end, { desc = "Find files (filtered)" })

vim.keymap.set("n", "<Leader>sf", function()
    find_files("Filtered files (no tests)", project_root(),
        { "fd", "--type", "f", "--exclude", "*test*/", "--exclude", "*.o", "--exclude", "*.out", "--exclude", "*.a" })
end, { desc = "Find files (filtered), skip test dirs" })

vim.keymap.set("n", "<Leader>sa", function()
    find_files("All files", project_root(), { "fd", "--type", "f", "--hidden" })
end, { desc = "Find all files (incl. hidden)" })

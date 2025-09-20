require "nvim-treesitter.configs".setup({
    ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "cuda",
        "diff",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
    },
    highlight = { enable = true },
    indent = {
        enable = true,
        disable = { "python" },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gs",
            node_incremental = "gi",
            node_decremental = "gd",
        },
    },
    use_languagetree = true,
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    additional_vim_regex_highlighting = { "cpp" },
})

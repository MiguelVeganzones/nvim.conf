require "nvim-treesitter.configs".setup({
    ensure_installed = {
        "bash",
        "c",
        "cpp",
        "cuda",
        "diff",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
    },
    highlight = { enable = true },
    indent = { enable = true },
})

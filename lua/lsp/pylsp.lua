vim.lsp.config("pylsp", {
    cmd = { "pylsp" },
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = { enabled = false },
                mccabe = { enabled = false },
                pyflakes = { enabled = false },
                flake8 = { enabled = true },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                black = { enabled = true },
                isort = { enabled = true },
                mypy = { enabled = true },
            }
        }
    }
})
vim.lsp.enable("pylsp")

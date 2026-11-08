-- Requires Neovim >= 0.12 (vim.pack)

--------------------
-- General
--------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.g.python3_host_prog = vim.fn.expand("~/.venvs/nvim/" ..
    (vim.fn.has("win32") == 1 and "Scripts/python.exe" or "bin/python"))
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.o.updatetime = 300
vim.o.showmode = false
vim.opt.wildignore = { "*.o", "*.a", "*.obj" }
vim.o.smartindent = true

--------------------
-- Files
--------------------
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undofile = true

vim.filetype.add({
    extension = {
        ll = "llvm",
        mir = "mir",
        td = "tablegen",
    },
    pattern = {
        [".*%.md%.es"] = "markdown",
        ["lit%..*cfg"] = "python",
    },
})

--------------------
-- Behaviour
--------------------
vim.opt.path:append("**")
vim.o.mouse = "a"

--------------------
-- Appearance
--------------------
-- Columns
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
-- Wrapping
vim.o.textwidth = 80
vim.o.linebreak = true
-- Tabs
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
-- Unprintable Symbols
vim.o.list = true
vim.opt.listchars = {
    tab = "» ",
    trail = "·",
    nbsp = "␣",
    extends = "►",
    precedes = "◄",
    conceal = "▒",
}
-- Popups
vim.o.winborder = "rounded"
-- Cursor
vim.o.scrolloff = 10
vim.o.cursorline = true
-- Miscellany
vim.o.showmatch = true
vim.o.lazyredraw = true

--------------------
-- Spelling
--------------------
vim.api.nvim_set_hl(0, "SpellBad", { bold = true, undercurl = true, sp = "Red" })
vim.api.nvim_set_hl(0, "SpellCap", { bold = true, fg = "LightBlue" })
vim.api.nvim_set_hl(0, "SpellRare", { italic = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "text", "tex" },
    callback = function(ev)
        vim.opt_local.spell = true
        -- *.md.es files are Spanish, everything else English
        vim.opt_local.spelllang = ev.file:match("%.md%.es$") and "es" or "en"
    end,
})

--------------------
-- Window
--------------------
vim.o.splitbelow = true
vim.o.splitright = true
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-Left>", "<C-w>5<", { desc = "Resize window thinner" })
vim.keymap.set("n", "<C-Right>", "<C-w>5>", { desc = "Resize window wider" })

--------------------
-- Copy Pasting
--------------------
vim.keymap.set({ "n", "x" }, "<Leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "x" }, "<Leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
vim.keymap.set({ "n", "x" }, "<Leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "x" }, "<Leader>P", '"+P', { desc = "Paste line from system clipboard" })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        -- hl_op replaces the deprecated on_yank in 0.13
        (vim.hl.hl_op or vim.hl.on_yank)()
    end,
})

--------------------
-- Search
--------------------
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "split" -- Preview substitutions live, as you type!
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

--------------------
-- Buffers
--------------------
for i = 1, 9 do
    vim.keymap.set("n", "<Leader>" .. i, "<cmd>buffer " .. i .. "<CR>", { desc = "Go to buffer " .. i })
end
vim.keymap.set("n", "<Leader>x", "<cmd>bd<CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })

--------------------
-- Visual
--------------------
vim.keymap.set("x", "<Leader>r", "\"hy:%s/\\<<C-r>h\\>//g<Left><Left>", { desc = "Replace selection in file" })

--------------------
-- Terminal
--------------------
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--------------------
-- Packages
--------------------
-- vim.pack has no build step, so run it here. Must be registered before vim.pack.add().
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if kind == "delete" then return end
        if name == "nvim-treesitter" then
            vim.schedule(function() vim.cmd("TSUpdate") end)
        elseif name == "markdown-preview.nvim" then
            vim.cmd.packadd(name)
            vim.fn["mkdp#util#install"]()
        end
    end,
})

vim.pack.add({
    { src = "https://github.com/NeogitOrg/neogit" },
    { src = "https://github.com/akinsho/git-conflict.nvim" },
    { src = "https://github.com/danymat/neogen" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/iamcco/markdown-preview.nvim" },
    { src = "https://github.com/junegunn/vim-easy-align" },
    { src = "https://github.com/lervag/vimtex",                  version = "master" },
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/nvim-lua/plenary.nvim" }, -- neogit dependency
    { src = "https://github.com/nvim-mini/mini.files" },
    { src = "https://github.com/nvim-mini/mini.pick" },
    { src = "https://github.com/nvim-neotest/nvim-nio" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/rcarriga/nvim-dap-ui" },
    { src = "https://github.com/nvim-mini/mini.icons" },
})

-- Command legend (shows pending keymaps, like kickstart)
require("which-key").setup({
    spec = {
        { "<Leader>c", group = "[C]ode" },
        { "<Leader>d", group = "[D]ebug" },
        { "<Leader>g", group = "[G]it / [G]o to" },
        { "<Leader>m", group = "[M]arkdown" },
        { "<Leader>n", group = "[N]eogen" },
        { "<Leader>q", group = "[Q]uickfix" },
        { "<Leader>s", group = "[S]earch" },
    },
})

-- Treesitter
require("plugins.treesitter")

-- Git
require("plugins.neogit")
require("plugins.git-conflict")

-- LSP
require("lsp.clangd")
require("lsp.lua_ls")
require("lsp.pylsp")
require("lsp.cmake")

-- AI stuff
-- require("plugins.avante")

vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, { desc = "[G]o to [D]efinition" })
vim.keymap.set("n", "<Leader>gi", vim.lsp.buf.implementation, { desc = "[G]o to [I]mplementation" })
vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references, { desc = "[G]o to [R]eferences" })
vim.keymap.set("n", "<Leader>h", vim.lsp.buf.hover, { desc = "[H]over docs" })
vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame symbol" })
vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
vim.keymap.set("n", "<Leader>f", function() vim.lsp.buf.format({ async = true }) end, { desc = "[F]ormat code" })

-- Files
require("plugins.mini-files")

-- DAP
require("plugins.nvim-dap")
require("plugins.nvim-dap-ui")

-- Pick
require("plugins.mini-pick")

-- VimTeX
require("plugins.vimtex")

-- Neogen
require("plugins.neogen")

-- Markdown Preview
require("plugins.mdpreview")

-- Icons
require("mini.icons").setup()

--------------------
-- Autocomplete
--------------------
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})
vim.opt.completeopt = { "menu", "menuone", "noselect" }

--------------------
-- Diagnostics
--------------------
local sev = vim.diagnostic.severity
vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    signs = {
        text = { [sev.ERROR] = "󰅚 ", [sev.WARN] = "󰀪 ", [sev.HINT] = "󰌶 ", [sev.INFO] = " " },
    },
    float = { source = true, header = "", prefix = "" },
})
vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, { desc = "Show line diagnostics in floating window" })
vim.keymap.set("n", "<Leader>qd", vim.diagnostic.setqflist, { desc = "Send all diagnostics to quickfix list" })
vim.keymap.set("n", "<Leader>qe", function()
    vim.diagnostic.setqflist({ severity = sev.ERROR })
end, { desc = "Send all errors to quickfix list" })
vim.keymap.set("n", "<Leader>l", vim.diagnostic.setloclist, { desc = "Send buffer diagnostics to location list" })
-- ]d / [d are Neovim defaults
vim.keymap.set("n", "]e", function()
    vim.diagnostic.jump({ count = 1, severity = sev.ERROR })
end, { desc = "Go to next error" })
vim.keymap.set("n", "[e", function()
    vim.diagnostic.jump({ count = -1, severity = sev.ERROR })
end, { desc = "Go to previous error" })

--------------------
-- Status Line
--------------------
require("custom.statusline")

--------------------
-- Miscellany
--------------------
vim.keymap.set("n", "<Leader>r", "<cmd>update | source<CR>", { desc = "Re-source file" })

-- Centered jumping
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })

-- Move text up/down
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("x", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("x", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Visual mode indentation
vim.keymap.set("x", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("x", ">", ">gv", { desc = "Indent right and reselect" })

-- i_ / i, text objects: work with any operator (vi_, ci,, yi_, ...)
for _, c in ipairs({ "_", ",", "\\", "/" }) do
    vim.keymap.set({ "x", "o" }, "i" .. c, ":<C-u>normal! T" .. c .. "vt" .. c .. "<CR>",
        { silent = true, desc = "Inside " .. c })
end

--------------------
-- Overrides
--------------------
-- llvm
if vim.fn.getcwd():match("llvm%-project") then
    local llvm_root = vim.fs.root(vim.fn.getcwd(), ".git")
    local llvm_vimrc = llvm_root and llvm_root .. "/llvm/utils/vim/vimrc"
    if llvm_vimrc and vim.fn.filereadable(llvm_vimrc) == 1 then
        vim.cmd.source(vim.fn.fnameescape(llvm_vimrc))
    end
end

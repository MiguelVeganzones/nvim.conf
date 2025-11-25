-------------------
-- General
--------------------
vim.g.mapleader = " "
vim.g.have_nerd_font = true
vim.cmd("filetype plugin indent on")
vim.g.python3_host_prog = vim.fn.expand("~/.venvs/nvim/" ..
    (vim.fn.has("win32") == 1 and "Scripts/python.exe" or "bin/python"))
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 1
vim.o.updatetime = 300
vim.o.timeoutlen = 1000
vim.o.compatible = false
vim.o.showmode = false
vim.opt.wildignore = { "*.o", "*.a", "*.obj" }
vim.o.smartindent = true
vim.o.wildmenu = true
vim.o.wildoptions = "pum"

-------------------
-- Files
--------------------
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undofile = true
vim.o.autoread = true
vim.o.autowrite = false

--------------------
-- Behaviour
--------------------
vim.opt.path:append("**")
vim.o.mouse = "a"
vim.o.encoding = "UTF-8"

--------------------
-- Appearance
--------------------
-- Columns
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
-- Wrapping
vim.o.wrap = true
vim.o.textwidth = 80
vim.o.linebreak = true
vim.o.breakat = " ^I!@*-+;:,./?" -- default
-- Tabs
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
-- Unprintable Symbols
vim.o.list = true
vim.opt.listchars = { -- Show unprintable symbols
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
vim.o.termguicolors = true
-- Miscellany
vim.o.showmatch = true
vim.o.lazyredraw = true
vim.o.laststatus = 2 -- Always show statusline
vim.o.showcmd = true

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
vim.keymap.set({ 'n', 'v', 'x' }, '<Leader>y', '"+y', { noremap = true, desc = "Yank to system clipboard" })
vim.keymap.set({ 'n', 'v', 'x' }, '<Leader>Y', '"+Y', { noremap = true, desc = "Yank line to system clipboard" })
vim.keymap.set({ 'n', 'v', 'x' }, '<Leader>p', '"+p', { noremap = true, desc = "Paste from system clipboard" })
vim.keymap.set({ 'n', 'v', 'x' }, '<Leader>P', '"+P', { noremap = true, desc = "Paste line from system clipboard" })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

--------------------
-- Search
--------------------
vim.o.ignorecase = true
vim.o.smartcase = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.o.incsearch = true
vim.o.inccommand = "split" -- Preview substitutions live, as you type!

--------------------
-- Buffers
--------------------
for i = 1, 9 do
    vim.api.nvim_set_keymap(
        "n",
        "<leader>" .. i,
        "<cmd>buffer " .. i .. "<CR>",
        { noremap = true, silent = true }
    )
end
vim.keymap.set("n", "<Leader>b", "<cmd>buffers<CR>", { noremap = true, silent = true, desc = "Show buffers" })
vim.keymap.set("n", "<Leader>x", "<cmd>bd<CR>", { noremap = true, silent = true, desc = "Close current buffer" })
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Prev buffer" })

--------------------
-- Visual
--------------------

vim.keymap.set("v", "<Leader>r", "\"hy:%s/<C-r>h//g<Left><Left>")

--------------------
-- Terminal
--------------------
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--------------------
-- Packages
--------------------
local enable_copilot = vim.env.NVIM_ENABLE_COPILOT == "1"
vim.pack.add({
    { src = "https://github.com/echasnovski/mini.pick" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/akinsho/git-conflict.nvim" },
    { src = "https://github.com/lervag/vimtex" },
    enable_copilot and { src = "https://github.com/github/copilot.vim.git" } or nil,
})

-- Diagnostic signs
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Treesitter
require("plugins/treesitter")

-- LSP
require("lsp.clangd")
require("lsp.lua_ls")
require("lsp.pylsp")
require("lsp.cmake")

vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, { desc = "[G]o to [D]efinition" })
vim.keymap.set("n", "<Leader>gi", vim.lsp.buf.implementation, { desc = "[G]o to [I]mplementation" })
vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references, { desc = "[G]o to [R]eferences" })
vim.keymap.set("n", "<Leader>h", vim.lsp.buf.hover, { desc = "[H]over docs" })
vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame symbol" })
vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
vim.keymap.set("n", "<Leader>f", function() vim.lsp.buf.format({ async = true }) end, { desc = "[F]ormat code" })

-- Oil
require("plugins.oil")

-- Pick
require("plugins.pick")

-- Copilot
if enable_copilot then
    require("plugins/copilot")
end

-- Git Conflict
require("plugins.git-conflict")

-- VimTeX
require("plugins.vimtex")

-- Copilot
if enable_copilot then
    require("plugins.copilot")
end

--------------------
-- Autocomplete
--------------------
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})
vim.opt.completeopt = { "menu", "menuone", "noselect" }

--------------------
-- Autopair
--------------------
-- vim.keymap.set("i", "'", "''<Left>")
-- vim.keymap.set("i", "\"", "\"\"<Left>")
-- vim.keymap.set("i", "(", "()<Left>")
-- vim.keymap.set("i", "{", "{}<Left>")
-- vim.keymap.set("i", "[", "[]<Left>")
-- vim.keymap.set("i", "/*", "/**/<Left><Left>")

--------------------
-- Diagnostics
--------------------
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float,
    { noremap = true, silent = true, desc = 'Show line diagnostics in floating window' })
vim.keymap.set('n', '<Leader>qd', vim.diagnostic.setqflist,
    { noremap = true, silent = true, desc = 'Send all diagnostics to quickfix list' })
vim.keymap.set('n', '<Leader>qe', function()
    vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end, { noremap = true, silent = true, desc = 'Send all errors to quickfix list' })
vim.keymap.set('n', '<Leader>l', vim.diagnostic.setloclist,
    { noremap = true, silent = true, desc = 'Send buffer diagnostics to location list' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true, silent = true, desc = 'Go to next diagnostic' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']e', function()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { noremap = true, silent = true, desc = 'Go to next error' })
vim.keymap.set('n', '[e', function()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { noremap = true, silent = true, desc = 'Go to previous error' })

--------------------
-- Status Line
--------------------
require("custom.statusline")

--------------------
-- Miscellany
--------------------
-- Source file
vim.keymap.set('n', '<Leader>r', ':update<CR> :source<CR>', { desc = "Re-source file" })

-- Centered jumping
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = "Half page up (centered)" })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = "Half page down (centered)" })

-- Move text up/down
vim.keymap.set('n', '<A-k>', ":m .-2<CR>==", { desc = 'Move line up' })
vim.keymap.set('n', '<A-j>', ":m .+1<CR>==", { desc = 'Move line down' })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Visual mode indentation
vim.keymap.set('v', "<", "<gv", { desc = 'Indent left and reselect' })
vim.keymap.set('v', ">", ">gv", { desc = 'Indent right and reselect' })

-- Text manipulation
vim.keymap.set('n', "vi_", "T_vt_")
vim.keymap.set('n', "ci_", "T_ct_")
vim.keymap.set('n', "di_", "T_dt_")
vim.keymap.set('n', "vi,", "T,vt,")
vim.keymap.set('n', "ci,", "T,ct,")
vim.keymap.set('n', "di,", "T,dt,")

--------------------
-- Overrides
--------------------
-- llvm
local cwd = vim.fn.getcwd()
if cwd:match("llvm%-project") then
    local llvm_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    vim.print("")
    if vim.v.shell_error == 0 then
        local llvm_vimrc = llvm_root .. "/llvm/utils/vim/vimrc"
        if vim.fn.filereadable(llvm_vimrc) == 1 then
            vim.cmd("source " .. vim.fn.fnameescape(llvm_vimrc))
        end
    end
end

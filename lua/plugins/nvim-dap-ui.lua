local dap = require("dap")
local dapui = require("dapui")

dapui.setup({
    floating = {
        border = "rounded",
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
})

dap.listeners.after.event_initialized["dapui"] = function() dapui.open() end
-- No auto-close: keeps the console/REPL visible after the program exits
vim.keymap.set("n", "<Leader>du", dapui.toggle, { desc = "Debug: toggle [U]I" })

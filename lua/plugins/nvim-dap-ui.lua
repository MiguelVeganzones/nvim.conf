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

dap.listeners.after.event_initialized["dapui"] = function()
    dapui.open()
end

dap.listeners.before.event_terminated["dapui"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui"] = function()
    dapui.close()
end

vim.keymap.set("n", "<leader>du", dapui.toggle, {
    desc = "Debug: Toggle UI",
})

vim.keymap.set({ "n", "v" }, "<leader>dp", function()
    dapui.eval()
end, {
desc = "Debug: Evaluate expression",
})

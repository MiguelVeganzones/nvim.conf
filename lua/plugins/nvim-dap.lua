local dap = require("dap")
local dapui = require("dapui")

-- =========================
-- Python
-- =========================

dap.configurations.python = {
    {
        type = "debugpy",
        request = "launch",
        name = "Launch current file",
        program = "${file}",
    },
}

-- =========================
-- C / C++
-- =========================

dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap" },
}

dap.configurations.c = {
    {
        name = "Launch (gdb)",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input(
                "Executable: ",
                vim.fn.getcwd() .. "/",
                "file"
            )
        end,
        cwd = "${workspaceFolder}",
    },
}

dap.configurations.cpp = dap.configurations.c

-- =========================
-- CMake
-- =========================

dap.adapters.cmake = {
    type = "pipe",
    pipe = "${pipe}",

    executable = {
        command = "cmake",
        args = {
            "--debugger",
            "--debugger-pipe",
            "${pipe}",
        },
    },
}

dap.configurations.cmake = {
    {
        name = "Debug CMake",
        type = "cmake",
        request = "launch",
    },
}

-- =========================
-- Keymaps
-- =========================

vim.keymap.set("n", "<F5>", dap.continue, {
    desc = "Debug: Continue",
})

vim.keymap.set("n", "<F10>", dap.step_over, {
    desc = "Debug: Step over",
})

vim.keymap.set("n", "<F11>", dap.step_into, {
    desc = "Debug: Step into",
})

vim.keymap.set("n", "<F12>", dap.step_out, {
    desc = "Debug: Step out",
})

vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, {
    desc = "Debug: Toggle breakpoint",
})

vim.keymap.set({ "n", "v" }, "<leader>dh", function()
    dapui.eval()
end, {
desc = "Debug: Evaluate",
})

vim.keymap.set("n", "<leader>dd", function()
    dap.terminate({
        disconnect_args = {
            terminateDebuggee = true,
        },
    })

    dapui.close()
end, {
desc = "Debug: Terminate",
})

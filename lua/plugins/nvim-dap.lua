local dap = require("dap")

-- =========================
-- PYTHON (debugpy, installed in the nvim venv)
-- =========================
dap.adapters.debugpy = {
  type = "executable",
  command = vim.g.python3_host_prog,
  args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
  {
    type = "debugpy",
    request = "launch",
    name = "Launch current file",
    program = "${file}",
  },
}

-- =========================
-- C / C++ (GDB)
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
      return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
  },
}

dap.configurations.cpp = dap.configurations.c

-- =========================
-- Keymaps
-- =========================

vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: step over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: step into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: step out" })
vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "Debug: toggle [B]reakpoint" })
vim.keymap.set({ "n", "x" }, "<Leader>dh", function()
    require("dap.ui.widgets").hover()
end, { desc = "Debug: [H]over value" })
vim.keymap.set({ "n", "x" }, "<Leader>dp", function()
    require("dap.ui.widgets").preview()
end, { desc = "Debug: [P]review value" })
vim.keymap.set("n", "<Leader>dd", function()
    dap.disconnect({ terminateDebuggee = true })
end, { desc = "Debug: [D]isconnect" })

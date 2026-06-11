local dap = require("dap")

-- =========================
-- PYTHON (debugpy)
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

vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F12>", dap.step_out)
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dd', function()
    dap.disconnect( { terminateDebuggee = true })
end)

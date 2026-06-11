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

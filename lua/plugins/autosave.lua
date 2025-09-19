require("auto-save").setup({
  enabled = true,
  trigger_events = {
    immediate_save = { "BufLeave", "FocusLost" },
    defer_save = { "InsertLeave" },
  },
  condition = function(buf)
    local fn = vim.fn
    if bo.buftype ~= "" then
      return false
    end
    if not bo.modifiable then
      return false
    end
    if bo.filetype == "oil" then
      return false
    end
    return true
  end,
  write_all_buffers = false,
  noautocmd = false,
  lockmarks = false,
  debounce_delay = 1000,
  debug = false,
})

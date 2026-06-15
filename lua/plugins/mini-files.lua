require("mini.files").setup({
    windows = {
        preview = true,
        width_focus = 30,
        width_preview = 50,
    },
})

vim.keymap.set("n", "-", function()
    local buf_name = vim.api.nvim_buf_get_name(0)

    if buf_name ~= "" then
        require("mini.files").open(buf_name, true)
    else
        require("mini.files").open(vim.uv.cwd(), true)
    end
end, {
    desc = "Open mini.files",
})

vim.keymap.set("n", "<leader>-", function()
    require("mini.files").open(vim.uv.cwd())
end, {
    desc = "Open mini.files at cwd",
})

vim.g.minifiles_show_dotfiles = true

local filter_show = function()
  return true
end

local filter_hide = function(fs_entry)
  return not vim.startswith(fs_entry.name, ".")
end

local toggle_dotfiles = function()
  vim.g.minifiles_show_dotfiles = not vim.g.minifiles_show_dotfiles

  local new_filter = vim.g.minifiles_show_dotfiles
      and filter_show
      or filter_hide

  require("mini.files").refresh({ content = { filter = new_filter } })
end

vim.keymap.set("n", "g.", toggle_dotfiles, {
  desc = "Toggle dotfiles",
})

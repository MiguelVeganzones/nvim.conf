_G.last_save_time = 0
local debounce_ms = 1000 -- minimum delay between saves

local function should_save(buf)
    local bo = vim.bo[buf]
    if bo.filetype == "oil" then return false end
    if bo.buftype ~= "" then return false end
    if not bo.modifiable then return false end
    return true
end

local function autosave(buf)
    if not should_save(buf) then return end

    local now = vim.now()
    if now - _G.last_save_time < debounce_ms then return end

    vim.api.nvim_buf_call(buf, function()
        if vim.bo.modified then
            vim.cmd("update")
        end
    end)

    _G.last_save_time = now

    -- Show a message in the command line
    vim.api.nvim_echo({{"AutoSaved buffer " .. buf .. " at " .. os.date("%H:%M:%S"), "Normal"}}, false, {})
end

-- Trigger auto-save on BufLeave, FocusLost, InsertLeave
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertLeave" }, {
    callback = function(ev)
        autosave(ev.buf)
    end,
})

-- ========================
-- Cached data
-- ========================
vim.b.git_branch = ""
vim.b.lsp_clients = "No LSP"

-- ========================
-- Cache updaters
-- ========================
local function update_git_branch()
    local branch = vim.fn.system(
        "git -C " .. vim.fn.expand("%:p:h") .. " branch --show-current 2>/dev/null"
    ):gsub("%s+", "")
    vim.b.git_branch = branch ~= "" and branch or "No Git"
end

local function update_lsp_clients()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients > 0 then
        vim.b.lsp_clients = table.concat(
            vim.tbl_map(function(c) return c.name end, clients),
            ", "
        )
    else
        vim.b.lsp_clients = "No LSP"
    end
end

-- ========================
-- Autocommands
-- ========================
vim.api.nvim_create_autocmd("BufEnter", { callback = update_git_branch })
vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach" }, { callback = update_lsp_clients })

-- ========================
-- Display functions (globals)
-- ========================
function _G.status_mode()
    local modes = {
        n = "NORMAL",
        i = "INSERT",
        v = "VISUAL",
        V = "V-LINE",
        ["\22"] = "V-BLOCK",
        c = "COMMAND",
        s = "SELECT",
        S = "S-LINE",
        ["\19"] = "S-BLOCK",
        R = "REPLACE",
        r = "REPLACE",
        ["!"] = "SHELL",
        t = "TERMINAL",
    }
    return modes[vim.fn.mode()] or vim.fn.mode():upper()
end

-- function _G.status_filetype()
--     return vim.bo.filetype ~= "" and vim.bo.filetype or "no ft"
-- end

function _G.status_wordcount()
    if vim.tbl_contains({ "markdown", "text", "tex" }, vim.bo.filetype) then
        return vim.fn.wordcount().words .. " words"
    end
    return ""
end

function _G.status_git_branch()
    return vim.b.git_branch or ""
end

function _G.status_lsp_clients()
    return vim.b.lsp_clients or "No LSP"
end

-- ========================
-- Statusline setup
-- ========================
vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })

vim.o.statusline = table.concat({
    "  %#StatusLineBold#%{v:lua.status_mode()}%#StatusLine |#",
    " | %f",
    " | %{v:lua.status_git_branch()}",
    --" | %{v:lua.status_filetype()}",
    " | %{v:lua.status_lsp_clients()}",
    " | %n",
    " | %{v:lua.status_wordcount()}",
    "%=",
    "%l:%c  %P ",
})

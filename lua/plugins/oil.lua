require("oil").setup({
    default_file_explorer = true,
    columns = { "icon" },
    view_options = {
        show_hidden = false,
        is_hidden_file = function(name, bufnr)
            if vim.endswith(name, ".") then
                return false
            end

            if vim.endswith(name, "errors.log") or vim.endswith(name, "general.log") then
                return false
            end

            -- Get the full path of the current buffer
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            -- Convert the oil:// format to a regular file path
            local filepath = bufname:gsub("^oil://", "") -- Remove the oil:// prefix

            -- Get the directory of the file
            local dirpath = vim.fn.fnamemodify(filepath, ":h") -- Get the directory path

            -- Check if the directory is a git repository
            local is_git_repo_cmd = "git -C " .. dirpath .. " rev-parse --is-inside-work-tree 2>/dev/null"
            local git_repo_handle = io.popen(is_git_repo_cmd)
            local is_git_repo_result = git_repo_handle and git_repo_handle:read("*a") or ""
            if git_repo_handle then
                git_repo_handle:close()
            end

            -- If not in a git repository, check for dotfiles
            if is_git_repo_result == "" then
                -- Check for dotfiles only if not in a git repo
                return vim.startswith(name, ".")
            end

            -- If we are in a git repository, run git check-ignore on the specific file to see if it's gitignored
            local git_check_cmd = "git -C " .. dirpath .. " check-ignore " .. vim.fn.shellescape(name)
            local git_handle = io.popen(git_check_cmd)
            local git_result = git_handle and git_handle:read("*a") or ""
            if git_handle then
                git_handle:close()
            end

            -- Hide the file if it is either git-ignored or a dotfile
            return (git_result ~= "") or vim.startswith(name, ".")
        end,
        is_always_hidden = function(name, bufnr)
            return false
        end,
    },
    use_default_keymaps = false,
    keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-v>"] = {
            "actions.select",
            opts = { vertical = true },
            desc = "Open the entry in a vertical split",
        },
        ["<C-s>"] = {
            "actions.select",
            opts = { horizontal = true },
            desc = "Open the entry in a horizontal split",
        },
        ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = {
            "actions.cd",
            opts = { scope = "tab" },
            desc = ":tcd to the current oil directory",
            mode = "n",
        },
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
    },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

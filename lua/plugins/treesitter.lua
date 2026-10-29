-- nvim-treesitter `main` branch: needs the `tree-sitter` CLI and a C compiler to install parsers
local languages = {
    "bash", "c", "cmake", "cpp", "cuda", "diff", "json", "lua", "markdown", "markdown_inline", "python",
}
if vim.fn.executable("tree-sitter") == 1 then
    require("nvim-treesitter").install(languages)
end

vim.api.nvim_create_autocmd("FileType", {
    callback = function(ev)
        local file = vim.uv.fs_stat(ev.file)
        if file and file.size > 100 * 1024 then return end -- skip large files
        if not pcall(vim.treesitter.start, ev.buf) then return end
        if ev.match ~= "python" then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end,
})

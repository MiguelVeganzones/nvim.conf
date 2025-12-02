if vim.fn.executable('zathura') == 1 then
    vim.g.vimtex_view_method = 'zathura'
else
    vim.g.vimtex_view_method = 'general'
    vim.g.vimtex_view_general_viewer = 'SumatraPDF'
    vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
end
vim.g.vimtex_root_patterns = {'.latexmkrc', 'main.tex', '*.tex'}
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.maplocalleader = " "
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_subfile = 1

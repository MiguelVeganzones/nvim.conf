-- :h syntax
vim.opt.spelllang = "en"
vim.g.tex_fold_enabled = true
vim.cmd("highlight SpellBad cterm=bold,undercurl gui=bold,undercurl guisp=Red")
vim.cmd("highlight SpellCap cterm=bold gui=bold, guifg=LightBlue")
vim.cmd("highlight SpellRare cterm=italic gui=italic")
vim.cmd("set spell")
local spellfile_path = vim.fn.stdpath('config') .. '/ftplugin/spell/tex/en.utf-8.add'
vim.cmd("set spellfile=" .. spellfile_path)

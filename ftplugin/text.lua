-- :h syntax
vim.opt.spelllang = "en"
vim.cmd("highlight SpellBad cterm=bold,undercurl gui=bold,undercurl guisp=Red")
vim.cmd("highlight SpellCap cterm=bold gui=bold, guifg=LightBlue")
vim.cmd("highlight SpellRare cterm=italic gui=italic")
vim.cmd("set spell")

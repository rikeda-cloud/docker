vim.cmd([[
augroup rainbow_lisp
	autocmd!
	autocmd VimEnter * RainbowParentheses (
augroup END
]])
vim.g.rainbow_max_level = 16
vim.g.rainbow_blacklist = {233, 234}

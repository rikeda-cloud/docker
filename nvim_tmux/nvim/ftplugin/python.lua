--python.lua

--settinng
vim.bo.autoindent = true
vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4


--keymap
vim.api.nvim_set_keymap('n', 'main', 'Goif __name__ == \"__main__\":<lf>', {noremap = true})
vim.api.nvim_set_keymap('i', 'print', 'print("")<left><left>', {noremap = true})

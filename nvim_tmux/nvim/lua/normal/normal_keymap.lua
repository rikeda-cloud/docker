--normal keymap
-- vim.api.nvim_set_keymap('n', 'wq', ':wq<CR>', {noremap = true})
-- vim.api.nvim_set_keymap('n', 'ww', ':w<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'qq', ':q!<CR>', {noremap = true})
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', {noremap = true})
vim.api.nvim_set_keymap('n', 'DD', ':%d<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'U', '<C-r>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-t>', '<Tab>', {noremap = true})
vim.api.nvim_set_keymap('n', 'top', '0', {noremap = true})
vim.api.nvim_set_keymap('n', 'end', '$', {noremap = true})

vim.api.nvim_set_keymap('n', '<S-k>', ':m -2<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<S-j>', ':m +1<CR>', {noremap = true})
-- vim.api.nvim_set_keymap('i', '(', '()<left>', {noremap = true})
-- vim.api.nvim_set_keymap('i', '{', '{}<left>', {noremap = true})
-- vim.api.nvim_set_keymap('i', '[', '[]<left>', {noremap = true})
-- vim.api.nvim_set_keymap('i', '\'', '\'\'<left>', {noremap = true})
-- vim.api.nvim_set_keymap('i', '"', '""<left>', {noremap = true})

vim.api.nvim_set_keymap('n', '+', '<C-a>', {noremap = true})
vim.api.nvim_set_keymap('n', '-', '<C-x>', {noremap = true})

vim.api.nvim_set_keymap('n', '<Leader>h', '^', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>j', '}', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>k', '{', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>l', '$', {noremap = true})

vim.api.nvim_set_keymap('n', '<C-h>', ':bprev<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', ':bnext<CR>', {noremap = true})

--plugins keymap
vim.api.nvim_set_keymap('n', '<C-n>', ":Fern . -reveal=% -drawer -toggle -width=30<CR>", { silent = true })

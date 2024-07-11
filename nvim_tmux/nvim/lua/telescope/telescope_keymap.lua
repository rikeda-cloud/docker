local builtin = require('telescope.builtin')
vim.keymap.set('n', '<Leader>find', builtin.find_files, {})
vim.keymap.set('n', '<Leader>gr', builtin.live_grep, {})
vim.keymap.set('n', '<Leader>re',":cdo s//g | update<left><left><left><left><left><left><left><left><left><left><left>" , {})


vim.keymap.set('n', '<Leader>buff', builtin.buffers, {})
-- vim.keymap.set('n', '<Leader>help', builtin.help_tags, {})

-- no use
-- vim.api.nvim_set_keymap('n', '<Leader>re', '<Cmd>lua require("telescope.builtin").grep_string { search = vim.fn.input("Replace: ") }<CR>', { noremap = true, silent = true })

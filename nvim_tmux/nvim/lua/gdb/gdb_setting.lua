local function nvim_set_var(name, value)
	vim.api.nvim_set_var(name, value)
end

local function nvim_exec(cmd)
	vim.api.nvim_command(cmd)
end

-- gdb setting
local function packadd_termdebug()
	nvim_exec("packadd termdebug")
end

packadd_termdebug()
nvim_set_var("termdebug_wide", 163)

-- keymap
vim.api.nvim_set_keymap('n', '<Leader>dbg', ':TermdebugCommand ', {noremap = true})

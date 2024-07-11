-- gcc.lua
vim.cmd('compiler gcc')
vim.cmd('setlocal makeprg=gcc\\ -o\\ %<\\ %')
vim.cmd('setlocal errorformat=%f:%l:%c:\\ %tarning:%m,%f:%l:%c:\\ %rror:%m,%-G%.%#')

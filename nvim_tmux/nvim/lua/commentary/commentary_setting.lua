vim.api.nvim_exec([[
	augroup cpp_commentary
		autocmd!
		autocmd FileType cpp setlocal commentstring=//\ %s
	augroup END
]], false)

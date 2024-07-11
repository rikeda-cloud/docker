require('git').setup({
	default_mappings = true,

	keymaps = {
		blame = "<Leader>gb",
		quit_blame = "q",
		browse = "<Leader>go",
		open_pull_request = "<Leader>gp",
		create_pull_request = "<Leader>gn",
		revert = "<Leader>g1",
		revert_file = "<Leader>g2",
		diff = "<Leader>gd",
		diff_close = "q"
	}

})

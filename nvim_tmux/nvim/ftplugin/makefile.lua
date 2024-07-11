--makefile.lua

--setting
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4

--keymap
vim.api.nvim_set_keymap('i', 'name', 'NAME<TAB>=<TAB>', {noremap = true})
vim.api.nvim_set_keymap('i', 'cc', 'CC<TAB>=<TAB>cc<lf>', {noremap = true})
vim.api.nvim_set_keymap('i', 'rm', 'RM<TAB>=<TAB>rm -f<lf>', {noremap = true})
vim.api.nvim_set_keymap('i', 'cflag', 'CFLAGS<TAB>=<TAB>-Wall -Wextra -Werror<lf>', {noremap = true})
vim.api.nvim_set_keymap('i', 'srcs', 'SRCS<TAB>=<TAB>main.c<lf>', {noremap = true})
vim.api.nvim_set_keymap('i', 'objs', 'OBJS<TAB>=<TAB>$(SRCS:%.c=%.o)<lf>', {noremap = true})
vim.api.nvim_set_keymap('i', 'rul', '$(NAME): $(OBJS)<lf><TAB>$(CC) $(CFLAGS) $^ -o $@<lf>', {noremap = true})
vim.api.nvim_set_keymap('i', 'cmp', '%.o: %.c<lf><TAB>$(CC) $(CFLAGS) -c $^ -o $@<lf>', {noremap = true})
vim.api.nvim_set_keymap('i', 'all', 'all: $(NAME)<lf>', {noremap = true})
vim.api.nvim_set_keymap('i', 'clean', 'clean:<lf><TAB>$(RM) *.o<lf>', {noremap = true})
vim.api.nvim_set_keymap('i', 'fclean', 'fclean:	clean<lf><TAB>$(RM) $(NAME)<lf>', {noremap = true})
vim.api.nvim_set_keymap('i', 're', 're:	fclean all<lf>', {noremap = true})
vim.api.nvim_set_keymap('i', 'pho', '.PHONY:	all clean fclean re', {noremap = true})

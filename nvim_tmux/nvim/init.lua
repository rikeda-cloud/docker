-- CPU使用率の特定のために使用した設定
-- vim.cmd([[
-- profile start nvim-profile.log
-- profile func *
-- profile file *
-- ]])

require "normal/normal_setting"

-- plugins
require "plugins"
require "lualine/lualine_setting"
require "tabline/tabline_setting"

require "coc/coc_setting"
require "coc/coc_keymap"
require "telescope/telescope_setting"
require "telescope/telescope_keymap"
require "rainbow/rainbow_setting"
-- require "indent/indent_setting"
require "tokyonight/tokyonight_setting"
require "gitsigns/gitsigns_setting"
require "git/git_setting"

require "alpha-nvim/alpha-nvim_setting"
require "colorizer/colorizer_setting"
require "barbar/barbar_setting"

-- normal
require "normal/normal_keymap"
require "42header/42header_setting"
require "42header/42header_keymap"
require "gdb/gdb_setting"
require "commentary/commentary_setting"

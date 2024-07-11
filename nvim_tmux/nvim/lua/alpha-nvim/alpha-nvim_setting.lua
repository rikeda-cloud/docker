local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
 return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
[[　　　　　　　　　　　　　　　　　　　　　　　　　＿＿ ＼]],
[[　　　　　　　　　　　　　　　　　　　　　　　／／　　 ｜]],
[[　　　　　　　　　　｜＼　　　　｜｜　／＿＿＿＿　　　 ｜]],
[[　　　　　　　　　　｜＼　　　＿　　＿＿　　　　＼　　｜ ]],
[[　　　　　　　　　　　｜　｜＿／　　　　　＼＼　　　＼｜ ]],
[[　　　　　　　　　／／　　＿＿＿＿　　　　　　＿／｜｜｜ ]],
[[　＿＼　　　　　／　＿　　　　　　＿＼　　　　　　　　｜ ]],
[[｜　＼　　　　／　｜　＼　　　　　　　＼＼／｜　　＼　｜ ]],
[[　＼　＼＼　／＿＿｜　｜＿＿　　　　　　　　／　　＼　＿ ]],
[[　＼　　＼＿　　　｜　＼　　　＿＿／｜　　｜＼　　｜／　 ]],
[[　　＼　　　　　　　　　　　　　／　／　　　　＼　｜　　 ]],
[[　　｜　　　　　　　　　　　　／　　｜＼　　　｜　｜＿　 ]],
[[　　／　　　　　　　　　　　／　　／　　＼　　｜　　＼　 ]],
[[　／　　　　　　　　　　　　　　　｜　　＼　　　｜｜　　 ]],
[[／　　　＿＿＿　　　　　　　　　　　　　　＼　　／　　　 ]],
[[｜　／　　　　＿＿＿＼　　　　　　　　　　＼　　＿＿　　 ]],
[[｜　　／　＿　　　＿　＿＿　　　　　　　　　｜　　＿／　 ]],
[[｜｜｜｜　／\   　／　＼　　＼＼　　　　　　　｜｜／　　 ]],
[[｜｜／　｜■  ｜　｜■｜　　　　＼　　　　　＿＿＿＿　　 ]],
[[／　　 　＼＿　 　＼　｜　　　　　＼　　　　　　　　｜　 ]],
[[／　　　　　　　　　＿　　　　　　　＼　　　＿／＿＿　　 ]],
[[｜　　　 |＼＿＿／|　　　　　　　　　｜　 　／　　　　　 ]],
[[｜　　　 \__＿＿__|  　　　　　　　　　＼　／／　　　　　]],
[[＼＼　　　　　　　　　　　　　　　　　／／　　　　　　　 ]],
[[　＼＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿／　　　　　       ]],
}

 dashboard.section.buttons.val = {
   dashboard.button("ft", "🔎  Find text", ":Telescope live_grep <CR>"),
   dashboard.button("ff", "🔍  Find file", ":Telescope find_files <CR>"),
   dashboard.button("r", "💙  Recently used files", ":Telescope oldfiles <CR>"),
   dashboard.button("ca", "🐎  Config alacritty", ":e ~/.alacritty.yml<CR>"),
   dashboard.button("cb", "🐈  Config bash", ":e ~/.bashrc<CR>"),
   dashboard.button("cl", "🦮  Config init.lua", ":e ~/.config/nvim/init.lua<CR>"),
   dashboard.button("ct", "🦇  Config tmux", ":e ~/.tmux.conf<CR>"),
   dashboard.button("new", "  New file", ":ene <BAR> startinsert <CR>"),
   dashboard.button("q", "💣  Quit Neovim", ":qa<CR>"),
}

local function footer()
 return "Don't Stop Until You are Proud..."
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- -- インデントレベルに基づいてコードのスコープを可視化
	use 'echasnovski/mini.indentscope'

	-- PackerXXX
	use 'wbthomason/packer.nvim'

	-- 対応する括弧やタグの視覚的なマッチ
	use {'andymass/vim-matchup', event = 'VimEnter'}

	-- 括弧や中括弧などのカッコを視覚的に強調表示
	use 'junegunn/rainbow_parentheses.vim'

	-- 括弧や引用符を追加、削除、変更するなどの操作
	use 'tpope/vim-surround'
	
	-- 選択したテキストや行をコメントアウト、コメント解除
	use 'tpope/vim-commentary'

	-- さまざまなソースからデータを検索し、結果をインタラクティブに表示 高機能な拡張機能検索フレームワーク。
	use {
		'nvim-telescope/telescope.nvim',
		tab = '0.1.2',
		requires = { {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'} }
	}
	use 'nvim-telescope/telescope-frecency.nvim'
	use 'nvim-telescope/telescope-fzy-native.nvim'

	-- ファイルの一覧表示機能。
	use 'lambdalisue/fern.vim'

	-- fernでnerdfontを使用できるようにする拡張
	use 'lambdalisue/fern-renderer-nerdfont.vim'

	--FernとGitを統合する。Fern上でGitリポジトリの状態を確認できる
	use 'lambdalisue/fern-git-status.vim'

	-- タブライン(エディタ上部に表示されるタブの一覧)をカスタマイズする
	use 'kdheepak/tabline.nvim'

	-- 高機能なステータスライン(バッファ、モード、ファイル情報などの状態を表示)のカスタマイズ
	use {
		'nvim-lualine/lualine.nvim',
		reqiures = {'nvim-tree/nvim-web-devicons', opt = true}
	}

	-- ファイルタイプや拡張子に応じてアイコンを表示する
	use 'ryanoasis/vim-devicons'

	-- 特殊文字のフォント
	use 'lambdalisue/nerdfont.vim'

	-- git side status
	use {
		'lewis6991/gitsigns.nvim',
		requires = {
			'nvim-lua/plenary.nvim'
		},
		config = function() require('gitsigns').setup() end
	}

	-- vscode -> neovim
	use {
	  'neoclide/coc.nvim',
	  branch = 'release'
	}

	-- color scheme
	use 'folke/tokyonight.nvim'

	-- 自動コード解析し、エラーや警告を表示、リンターやフォーマッターと連携
	use {
		'w0rp/ale',
		ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
		cmd = 'ALEEnable',
		config = 'vim.cmd[[ALEEnable]]'
	}

	-- logファイルのハイライトカラーの自動設定
	use 'MTDL9/vim-log-highlighting'

	-- SQLを記述し、SPACEを押すと自動でおおもじにしてくれる
	use 'jorengarenar/vim-SQL-UPPER'

	-- viのみの時のデフォルト画面のカスタム
	use 'goolord/alpha-nvim'

	-- 42header
	use '42Paris/42header'

	-- color #FF00FF
	use 'norcalli/nvim-colorizer.lua'

	-- tab rich
	use 'romgrk/barbar.nvim'
	use 'nvim-tree/nvim-web-devicons'

	-- 括弧の自動補完
	use 'jiangmiao/auto-pairs'

	-- Git
	use 'dinhhuy258/git.nvim'
end)

vim.g.barbar_auto_setup = false -- 自動セットアップを無効化

require'barbar'.setup {
    animation = true,  -- アニメーションを有効化
    highlight_alternate = false,  -- 交互のバッファをハイライトしない
    icons = {
        buffer_index = false,  -- バッファのインデックスを表示しない
        buffer_number = false,  -- バッファの番号を表示しない
        button = '',  -- タブボタンのアイコン
        diagnostics = {
            [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
            [vim.diagnostic.severity.WARN] = {enabled = false},
            [vim.diagnostic.severity.INFO] = {enabled = false},
            [vim.diagnostic.severity.HINT] = {enabled = true},
        },
        gitsigns = {
            added = {enabled = true, icon = '+'},
            changed = {enabled = true, icon = '~'},
            deleted = {enabled = true, icon = '-'},
        },
        filetype = {
            custom_colors = false,
            enabled = true,
        },
        separator = {left = '▎', right = ''},
        separator_at_end = true,
        modified = {button = '●'},
        pinned = {button = '', filename = true},
        preset = 'default',
        alternate = {filetype = {enabled = false}},
        current = {buffer_index = true},
        inactive = {button = '×'},
        visible = {modified = {buffer_number = false}},
    },

    insert_at_end = true,  -- 新しいバッファをリストの最後に挿入
    insert_at_start = false,  -- 新しいバッファをリストの最初に挿入
    maximum_padding = 1,  -- タブを囲む最大の余白幅を設定
    minimum_padding = 1,  -- タブを囲む最小の余白幅を設定
    maximum_length = 30,  -- バッファ名の最大長を設定
    minimum_length = 0,  -- バッファ名の最小長を設定
    semantic_letters = true,  -- バッファ選択時のセマンティックな文字を有効化
    sidebar_filetypes = {
        NvimTree = true,
        undotree = {text = 'undotree'},
        ['neo-tree'] = {event = 'BufWipeout'},
        Outline = {event = 'BufWinLeave', text = 'symbols-outline'},
    },
    letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',  -- バッファに割り当てる文字の順序
    no_name_title = nil,  -- 名前のないバッファのタイトル
}


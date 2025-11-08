require("sshfs"):setup()

require("fuse-archive"):setup({
	smart_enter = true,
	excluded_extensions = { "docx", "xlsx" },
})

-- cross-instance yank
require("session"):setup({
	sync_yanked = true,
})

require("whoosh"):setup({})

require("mux"):setup({
	aliases = {
		eza_tree_1 = {
			previewer = "piper",
			args = {
				'cd "$1" && LS_COLORS="ex=32" eza --oneline --tree --level 1 --color=always --icons=always --group-directories-first --no-quotes .',
			},
		},
		eza_tree_2 = {
			previewer = "piper",
			args = {
				'cd "$1" && LS_COLORS="ex=32" eza --oneline --tree --level 2 --color=always --icons=always --group-directories-first --no-quotes .',
			},
		},
		eza_tree_3 = {
			previewer = "piper",
			args = {
				'cd "$1" && LS_COLORS="ex=32" eza --oneline --tree --level 3 --color=always --icons=always --group-directories-first --no-quotes .',
			},
		},
		eza_tree_4 = {
			previewer = "piper",
			args = {
				'cd "$1" && LS_COLORS="ex=32" eza --oneline --tree --level 4 --color=always --icons=always --group-directories-first --no-quotes .',
			},
		},
	},
})

require("sshfs"):setup()

require("fuse-archive"):setup({
	smart_enter = true,
	excluded_extensions = { "docx", "xlsx" },
})

-- cross-instance yank
require("session"):setup({
	sync_yanked = true,
})

local bookmarks = {
	{ tag = "yazi", path = "~/.config/yazi", key =	"y" },
	{ tag = "nvim", path = "~/.config/nvim", key =	"v" },
	{ tag = "Documents", path = "~/Documents", key =	"o" },
}
require("whoosh"):setup({
	bookmarks = bookmarks,

special_keys = {
    create_temp = false,         -- Create a temporary bookmark from the menu
    fuzzy_search = false,        -- Launch fuzzy search (fzf)
    history = "<Tab>",               -- Open directory history
    previous_dir = "<Backspace>",    -- Jump back to the previous directory
  },
})

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

require("eza-preview"):setup({
	-- Set the tree preview to be default (default: true)
	default_tree = true,

	-- Directory depth level for tree preview (default: 3)
	level = 3,

	-- Show file icons
	icons = true,

	-- Follow symlinks when previewing directories (default: true)
	follow_symlinks = true,

	-- Show target file info instead of symlink info (default: false)
	dereference = false,

	-- Show hidden files (default: true)
	all = true,

	-- Ignore files matching patterns (default: {})
	-- ignore_glob = "*.log"
	-- ignore_glob = { "*.tmp", "node_modules", ".git", ".DS_Store" }
	-- SEE: https://www.linuxjournal.com/content/pattern-matching-bash to learn about glob patterns
	ignore_glob = {},

	-- Ignore files mentioned in '.gitignore'  (default: true)
	git_ignore = true,

	-- Show git status (default: false)
	git_status = false,
})

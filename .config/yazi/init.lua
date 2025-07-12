require("eza-preview"):setup({
	-- Set the tree preview to be default (default: true)
	default_tree = true,

	-- Directory depth level for tree preview (default: 3)
	level = 3,

	-- Follow symlinks when previewing directories (default: false)
	follow_symlinks = true,

	-- Show target file info instead of symlink info (default: false)
	dereference = false,

	-- Show hidden files (default: true)
	all = true,
})

-- cross-instance yank
require("session"):setup({
	sync_yanked = true,
})

require("bookmarks"):setup({
	last_directory = { enable = false, persist = false, mode = "dir" },
	persist = "vim",
	desc_format = "parent",
	file_pick_mode = "parent",
	custom_desc_input = false,
	notify = {
		enable = true,
		timeout = 1,
		message = {
			new = "New bookmark '<key>' -> '<folder>'",
			delete = "Deleted bookmark in '<key>'",
			delete_all = "Deleted all bookmarks",
		},
	},
})

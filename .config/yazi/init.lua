require("eza-preview"):setup({
	follow_symlinks = true,
})

require("dual-pane"):setup()

-- cross-instance yank
require("session"):setup({
	sync_yanked = true,
})
require("bunny"):setup({
	hops = {
		{ key = "y", path = "~/.config/yazi" },
	},
})

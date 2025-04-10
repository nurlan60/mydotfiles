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
		{ key = "m", path = "~/onedrive-sdu/teach/Matan4", desc = "Mat An" },
		{ key = "f", path = "~/onedrive-sdu/teach/FAN", desc = "Func An" },
		{ key = "y", path = "~/.config/yazi" },
	},
})

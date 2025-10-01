require("sshfs"):setup()

require("fuse-archive"):setup({
	smart_enter = true,
})

-- cross-instance yank
require("session"):setup({
	sync_yanked = true,
})

require("whoosh"):setup({})

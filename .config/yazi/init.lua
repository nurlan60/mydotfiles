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

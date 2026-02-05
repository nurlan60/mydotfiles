require("sshfs"):setup()

-- cross-instance yank
require("session"):setup({
	sync_yanked = true,
})

require("whoosh"):setup({
	bookmarks = {
		{ tag = "yazi", path = "~/.config/yazi", key =	"y" },
		{ tag = "nvim", path = "~/.config/nvim", key =	"v" },
		{ tag = "Documents", path = "~/Documents", key =	"o" },
		{ tag = "rpi", path = "sftp://rpi//home/nurlan", key =	"r" },
	},
	special_keys = {
    create_temp = false,         -- Create a temporary bookmark from the menu
    fuzzy_search = false,        -- Launch fuzzy search (fzf)
    history = "<Tab>",               -- Open directory history
    previous_dir = "<Backspace>",    -- Jump back to the previous directory
  },
})


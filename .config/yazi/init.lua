-- cross-instance yank
require("session"):setup({
	sync_yanked = true,
})

-- show symlinks in status
-- function Status:name()
-- 	local h = self._tab.current.hovered
-- 	if not h then
-- 		return ui.Line({})
-- 	end
-- 	local linked = ""
-- 	if h.link_to ~= nil then
-- 		linked = " -> " .. tostring(h.link_to)
-- 	end
-- 	return ui.Line(" " .. h.name .. linked)
-- end

-- -- show host in header
-- Header:children_add(function()
-- 	if ya.target_family() ~= "unix" then
-- 		return ui.Line({})
-- 	end
-- 	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
-- end, 500, Header.LEFT)

-- Bookmarks setup
require("bookmarks"):setup({
	persist = "vim",
	desc_format = "parent",
	file_pick_mode = "parent",
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

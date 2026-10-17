local add = vim.pack.add
-----------------------------------------------
---kbswitch
-----------------------------------------------
local os_name = vim.loop.os_uname().sysname

if os_name == "Darwin" then
	add({ "https://github.com/riodelphino/macime.nvim" })
	require("macime").setup({
		vim = {
			ttimeoutlen = 0, -- Reduce delay after InsertLeave and InsertEnter
		},
		save = {
			enabled = true,
			scope = "session", -- Save previous IME per nvim pid
		},
		socket = {
			enabled = true, -- Enable `macimed` launchd service for blazing faster switching
		},
		-- exclude = {
		-- 	filetype = { "TelescopePrompt", "snacks_picker_input", "neo-tree-popup", "neo-tree-filter" }, -- Exclude specific filetypes
		-- },
	})
else
	vim.cmd("packadd kbswitch.nvim")
	require("kbswitch").setup({})
end
-----------------------------------------------
--- Typst
-----------------------------------------------
add({ "https://github.com/chomosuke/typst-preview.nvim" })
require 'typst-preview'.setup {
  ormatterMode = "typstyle", -- or "typstfmt"
  formatterProseWrap = true, -- wrap lines in content mode
  formatterPrintWidth = 80,  -- limit line length to 80 if possible
  formatterIndentSize = 4,   -- indentation width
}


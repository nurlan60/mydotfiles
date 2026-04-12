local add = vim.pack.add
-----------------------------------------------
--- Vimtex
-----------------------------------------------
add({ "https://github.com/lervag/vimtex" })
vim.g.vimtex_view_method = "sioyek"
vim.g.vimtex_view_sioyek_options = "--new-window"
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_quickfix_ignore_filters = {
	"Underfull \\hbox",
	"Overfull \\hbox",
	"LaTeX Warning: Unused global option(s):",
}
-----------------------------------------------
--- Macime: keyboard switching
-----------------------------------------------
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

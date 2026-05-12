local viewer, opt
local os_name = vim.loop.os_uname().sysname

if os_name == "Linux" then
	viewer = "zathura"
	opt = { "--synctex-forward", "%l:1:%f", "%p" }
elseif os_name == "Darwin" then
	viewer = "/Applications/Skim.app/Contents/SharedSupport/displayline"
	opt = { "-b", "-g", "%l", "%p", "%f" }
elseif os_name == "Windows_NT" then
	viewer = ""
	opt = ""
end

return {
	settings = {
		texlab = {
			build = {
				args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
			},
			forwardSearch = {
				executable = viewer,
				args = opt,
			},
			chktex = {
				onOpenAndSave = true, -- Enable linting diagnostics
			},
			diagnostics = {
				ignoredPatterns = {
					-- Rust regexes. Match the diagnostic text you want to suppress.
					[[Underfull \\hbox]],
					-- If you want to be extra broad:
					-- [[Underfull \\hbox.*]],
				},
			},
		},
	},
}

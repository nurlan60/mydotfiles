local viewer = "displayline"
local options = {
  "%l",
  "%p",
  "%f",
}
local os_name = vim.loop.os_uname().sysname
if os_name == "Linux" then
  viewer = "zathura"
  options = {
    "--synctex-forward",
    "%l:1:%f",
    "%p",
  }
elseif os_name == "Windows" then
  -- Do something for Windows
end
vim.lsp.config('texlab', {
	 settings = {
     texlab = {
        forwardSearch = {
        		executable = viewer,
        		args = options,
        },
		 latexFormatter = 'tex-fmt',
			},
		},
})

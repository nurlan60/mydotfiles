local cmd
local viewer

local os_name = vim.loop.os_uname().sysname

if os_name == "Linux" then
  viewer = "zathura"
elseif os_name == "Darwin" then
  viewer = "open -a Skim"
elseif os_name == "Windows_NT" then
  viewer = ""
end

cmd = string.format(":!latexmk -pdf -pv -e '$pdf_previewer=\"%s\";' %%<CR>",viewer)

vim.keymap.set('n', '<Localleader>ls', cmd, { buffer = true })

local cmd = [[
  :!latexmk -pdf -pv -e '$pdf_previewer="open -a Skim";' %<CR>
]]
vim.keymap.set('n', '<Localleader>ls',cmd, { buffer = true })

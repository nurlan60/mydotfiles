-- Only load if filetype is correctly set
if vim.bo.filetype ~= 'typst' then return end

-- Buffer-local settings
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.textwidth = 80
-- vim.bo.comments = 'sO:/*,mO:*,ex:*/,//'
vim.bo.commentstring = '// %s'

vim.keymap.set('n', '<Localleader>tc', ':!typst compile %<CR>', { buffer = true, desc = 'Typst [C]ompile' })
-- vim.keymap.set("n", "<Localleader>tt", ":TypstPreview<CR>", { buffer = true })
vim.keymap.set("n", "<Localleader>tt", ":TypstPreviewToggle<CR>", { buffer = true })

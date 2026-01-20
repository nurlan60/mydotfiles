vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
---------------------------------------------
vim.keymap.set('n', '<leader>e', '<cmd>lua MiniFiles.open()<cr>', {desc = 'File explorer'})
---------------------------------------------
vim.keymap.set('n', '<leader><space>', '<cmd>Pick buffers<cr>', {desc = 'Search open files'})
vim.keymap.set('n', '<leader>ff', '<cmd>Pick files<cr>', {desc = 'Search all files'})
vim.keymap.set('n', '<leader>fh', '<cmd>Pick help<cr>', {desc = 'Search help tags'})
---------------------------------------------
vim.keymap.set({'n'}, '<leader>tb', '<cmd>LspTexlabBuild<CR>', {desc = 'Compile LaTeX'})
vim.keymap.set({'n'}, '<leader>tv', '<cmd>LspTexlabForward<CR>', {desc = 'Forward View LaTeX'})
---------------------------------------------

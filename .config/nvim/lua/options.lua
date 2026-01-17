
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.wrap = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.hlsearch = false
vim.o.signcolumn = 'yes'
vim.o.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
vim.o.backup = false -- Don't create backup files
vim.o.writebackup = false -- Don't create backup before writing
vim.o.swapfile = false -- Don't create swap files
vim.o.undofile = true -- Persistent undo

vim.g.mapleader = ' '
-----------------------------------------------------
-- Spelling --
---------------
vim.opt.spelllang = "en_us,ru"
vim.keymap.set('n', '<leader>s', ':set spell<cr>')
--------------------------------------------------------
-- Encoding --
--------------
vim.opt.fileencodings = "utf-8, cp1251, cp866, koi8-r,ucs-2le"
-------------
-- <F7> EOL format (dos <CR><NL>,unix <NL>,mac <CR>)
vim.cmd([[
    set  wildmenu
    set  wcm=<Tab>
    menu EOL.unix :set fileformat=unix<CR>
    menu EOL.dos  :set fileformat=dos<CR>
    menu EOL.mac  :set fileformat=mac<CR>
    map  <F7> :emenu EOL.<Tab>
]])

-- F8 Change encoding
vim.cmd([[
    set  wildmenu
    set  wcm=<Tab>
    menu Encoding.cp1251     :e ++enc=cp1251 ++ff=dos<CR>
    menu Encoding.cp866      :e ++enc=ibm866 ++ff=dos<CR>
    menu Encoding.koi8-r     :e ++enc=koi8-r ++ff=unix<CR>
    menu Encoding.utf-8      :e ++enc=utf-8<CR>
    menu Encoding.ucs-2le    :e ++enc=ucs-2le<CR>
    nmap <F8> :emenu Encoding.<Tab>
]])

-- F9 Convert file encoding
vim.cmd([[
    set  wildmenu
    set  wcm=<Tab>
    menu File-Encoding.cp1251    :set fenc=cp1251<CR>
    menu File-Encoding.cp866     :set fenc=ibm866<CR>
    menu File-Encoding.koi8-r    :set fenc=koi8-r<CR>
    menu File-Encoding.utf-8     :set fenc=utf-8<CR>
    menu File-Encoding.ucs-2le   :set fenc=ucs-2le<CR>
    nmap  <F9> :emenu File-Encoding.<Tab>
]])

-------------------------------------------------------

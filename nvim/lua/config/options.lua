-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-----------------------------------------------------
-- Wrap --
---------------
vim.opt.wrap = true
-----------------------------------------------------
-- Spelling --
---------------
vim.opt.spelllang = "en_us,ru"

-----------------------------------------------------
-- Encoding --
--------------
-- cod Change encoding
vim.api.nvim_command([[
    set  wildmenu
    set  wcm=<Tab>
    menu Enc.utf-8      :e ++enc=utf-8<CR>
    menu Enc.cp1251     :e ++enc=cp1251 ++ff=dos<CR>
    menu Enc.cp866      :e ++enc=ibm866 ++ff=dos<CR>
    menu Enc.koi8-r     :e ++enc=koi8-r ++ff=unix<CR>
    menu Enc.ucs-2le    :e ++enc=ucs-2le<CR>
    nmap kod :emenu Enc.<Tab>
]])

-- con Convert file encoding
vim.api.nvim_command([[
    set  wildmenu
    set  wcm=<Tab>
    menu FEnc.utf-8     :set fenc=utf-8<CR>
    menu FEnc.cp1251    :set fenc=cp1251<CR>
    menu FEnc.cp866     :set fenc=ibm866<CR>
    menu FEnc.koi8-r    :set fenc=koi8-r<CR>
    menu FEnc.ucs-2le   :set fenc=ucs-2le<CR>
    nmap  kon :emenu FEnc.<Tab>
]])

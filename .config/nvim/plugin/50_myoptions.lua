vim.g.maplocalleader = ',' -- Use `,` as <Localleader> key
vim.cmd.colorscheme("catppuccin")
vim.opt.spell = true
vim.opt.spelllang = { 'en_us', 'ru' }
vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'
---------------------------------------------
--- clipboard toggle
---------------------------------------------
vim.opt.clipboard = "unnamedplus"
vim.keymap.set('n', '<leader>y', function()
  if vim.opt.clipboard:get()[1] == 'unnamedplus' then
    vim.opt.clipboard = ''
    print('Clipboard: Internal')
  else
    vim.opt.clipboard = 'unnamedplus'
    print('Clipboard: System (unnamedplus)')
  end
end, { desc = 'Toggle unnamedplus clipboard' })
---------------------------------------------
-- Encoding --
---------------------------------------------
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

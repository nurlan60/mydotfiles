local socket_path = "/tmp/nvim-latex.pipe"
if not vim.loop.fs_stat(socket_path) then
  vim.fn.serverstart(socket_path)
end


vim.g.maplocalleader = ',' -- Use `,` as <Localleader> key
vim.cmd.colorscheme("catppuccin")
vim.opt.spell = false
vim.opt.wrap = true
vim.opt.spelllang = { 'en_us', 'ru' }
vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'
vim.opt.mousescroll = "ver:1,hor:1"
---------------------------------------------
--- clipboard toggle
---------------------------------------------
vim.opt.clipboard = "unnamedplus"
vim.keymap.set('n', '\\y', function()
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
-- Список поддерживаемых кодировок
local encodings = { "utf-8", "cp1251", "cp866", "koi8-r" }

-- Две основные операции
local operations = {
  ["Reopen with encoding"] = function(enc)
    vim.cmd("edit! ++enc=" .. enc)
  end,
  ["Set encoding and reopen"] = function(enc)
    vim.bo.fileencoding = enc
    vim.cmd("write")
    vim.cmd("edit! ++enc=" .. enc)
  end,
}

local function encoding_menu()
  local categories = vim.tbl_keys(operations)
  table.sort(categories)
  
  -- 1. Выбор действия (Reopen... или Set...)
  vim.ui.select(categories, { prompt = "Select action: " }, function(category)
    if not category then return end
    
    -- 2. Выбор кодировки из списка
    vim.ui.select(encodings, { prompt = category .. ": " }, function(enc)
      if not enc then return end
      
      -- Безопасный отложенный вызов, чтобы mini.pick успел закрыться
      vim.schedule(function()
        operations[category](enc)
        vim.notify(category .. " → " .. enc, vim.log.levels.INFO)
      end)
    end)
  end)
end

-- Создаем команду для удобного вызова (:EncodingMenu)
vim.api.nvim_create_user_command("EncodingMenu", encoding_menu, {})

vim.keymap.set("n", "<Leader>c", ':EncodingMenu<CR>', {
    desc = "Encoding",
})

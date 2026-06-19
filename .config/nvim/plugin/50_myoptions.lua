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
vim.opt.fileencodings = "utf-8, cp1251, cp866, koi8-r"
-------------
local actions = {
    ["EOL format"] = {
        unix = function()
            vim.bo.fileformat = "unix"
        end,
        dos = function()
            vim.bo.fileformat = "dos"
        end,
        mac = function()
            vim.bo.fileformat = "mac"
        end,
    },

    ["Reopen with encoding"] = {
        cp1251 = function()
            vim.cmd("edit ++enc=cp1251 ++ff=dos")
        end,
        cp866 = function()
            vim.cmd("edit ++enc=ibm866 ++ff=dos")
        end,
        ["koi8-r"] = function()
            vim.cmd("edit ++enc=koi8-r ++ff=unix")
        end,
        ["utf-8"] = function()
            vim.cmd("edit ++enc=utf-8")
        end,
    },

    ["Convert file encoding"] = {
        cp1251 = function()
            vim.bo.fileencoding = "cp1251"
        end,
        cp866 = function()
            vim.bo.fileencoding = "ibm866"
        end,
        ["koi8-r"] = function()
            vim.bo.fileencoding = "koi8-r"
        end,
        ["utf-8"] = function()
            vim.bo.fileencoding = "utf-8"
        end,
    },
}

local function encoding_menu()
    local categories = vim.tbl_keys(actions)
    table.sort(categories)

    vim.ui.select(categories, {
        prompt = "Select action:",
    }, function(category)
        if not category then
            return
        end

        local submenu = actions[category]
        local items = vim.tbl_keys(submenu)
        table.sort(items)

        vim.ui.select(items, {
            prompt = category .. ":",
        }, function(choice)
            if not choice then
                return
            end

            submenu[choice]()

            vim.notify(category .. " → " .. choice)
        end)
    end)
end

vim.keymap.set("n", "<Leader>c", encoding_menu, {
    desc = "Encoding/EOL menu",
})

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
-----------------------------------------------------------
--- Mini install ---
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    -- Uncomment next line to use 'stable' branch
    -- '--branch', 'stable',
    'https://github.com/nvim-mini/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end
require('mini.deps').setup({})
-----------------------------------------------------------
--- Colorscheme ---
MiniDeps.add('folke/tokyonight.nvim')
vim.cmd.colorscheme('tokyonight')
--------------------------------------------------------
require('mini.files').setup({
	mappings = {
    show_help = 'gh',
  },
})
vim.keymap.set('n', '<leader>e', '<cmd>lua MiniFiles.open()<cr>', {desc = 'File explorer'})
-------------------------------------------------------
require('mini.pick').setup({})
vim.keymap.set('n', '<leader><space>', '<cmd>Pick buffers<cr>', {desc = 'Search open files'})
vim.keymap.set('n', '<leader>ff', '<cmd>Pick files<cr>', {desc = 'Search all files'})
vim.keymap.set('n', '<leader>fh', '<cmd>Pick help<cr>', {desc = 'Search help tags'})
-------------------------------------------------------
require('mini.snippets').setup({})
require('mini.completion').setup({})
require('mini.pairs').setup({})
-----------------------------------------------------------
--- VimTex ---
MiniDeps.add('lervag/vimtex')
vim.g.vimtex_view_method = 'sioyek'
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_quickfix_ignore_filters = {
         "Underfull \\hbox",
	 "Overfull \\hbox",
         "LaTeX Warning: Unused global option(s):",
			}
-------------------------------------------------------
--- TexLab ---
MiniDeps.add('neovim/nvim-lspconfig')
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
vim.lsp.enable('texlab')
vim.keymap.set({'n'}, '<leader>tb', '<cmd>LspTexlabBuild<CR>', {desc = 'Compile LaTeX'})
vim.keymap.set({'n'}, '<leader>tv', '<cmd>LspTexlabForward<CR>', {desc = 'Forward View LaTeX'})
---------------------------------------------------
-- Spelling --
---------------
vim.opt.spelllang = "en_us,ru"
vim.keymap.set('n', '<leader>s', ':set spell<cr>')
-----------------------------------------------------
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
-- Automatically switch keyboard layout
--------------
local autocmd = vim.api.nvim_create_autocmd
local NORMAL_LAYOUT
local get_command
local change_command

local os_name = vim.loop.os_uname().sysname

if os_name == "Linux" then
  NORMAL_LAYOUT = "0"
  get_command = "niri msg -j keyboard-layouts | jq '.current_idx'"
  change_command = "niri msg action switch-layout"
elseif os_name == "Darwin" then
  NORMAL_LAYOUT = "com.apple.keylayout.ABC"
  get_command = "macism"
  change_command = "macism"
elseif os_name == "Windows_NT" then
  NORMAL_LAYOUT = "1033"
  get_command = "im-select.exe"
  change_command = "im-select.exe"
end

local get_current_layout = function()
  local file = io.popen(get_command)
  local output = file:read()
  file:close()
  return output
end

local change_layout = function(layout)
  vim.fn.jobstart(string.format(change_command .. " %s", layout))
end

local manage_layout = function(current_layout, layout_to_change)
  if current_layout ~= layout_to_change then
    change_layout(layout_to_change)
  end
end

local saved_layout = get_current_layout()

-- When leaving Insert Mode:
-- 1. Save the current layout
-- 2. Switch to the US layout
autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    vim.schedule(function()
      saved_layout = get_current_layout()
      manage_layout(saved_layout, NORMAL_LAYOUT)
    end)
  end,
})

-- When Neovim gets focus:
-- 1. Save the current layout
-- 2. Switch to the US layout if Normal Mode or Visual Mode is the current mode
autocmd({ "FocusGained", "CmdlineLeave" }, {
  pattern = "*",
  callback = function()
    vim.schedule(function()
      saved_layout = get_current_layout()
      local current_mode = vim.api.nvim_get_mode().mode
      if
        current_mode == "n"
        or current_mode == "no"
        or current_mode == "v"
        or current_mode == "V"
        or current_mode == "^V"
      then
        manage_layout(saved_layout, NORMAL_LAYOUT)
      end
    end)
  end,
})

-- When Neovim loses focus
-- When entering Insert Mode:
-- 1. Switch to the previously saved layout
autocmd({ "FocusLost", "InsertEnter" }, {
  pattern = "*",
  callback = function()
    vim.schedule(function()
      manage_layout(NORMAL_LAYOUT, saved_layout)
    end)
  end,
})

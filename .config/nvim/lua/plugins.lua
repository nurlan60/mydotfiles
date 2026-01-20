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
---------------------------------------------------
require('mini.deps').setup({})
require('mini.ai').setup()
require('mini.basics').setup()
require('mini.bracketed').setup()
require('mini.completion').setup({})
require('mini.files').setup()
require('mini.icons').setup()
require('mini.indentscope').setup()
require('mini.pairs').setup({})
require('mini.pick').setup({})
require('mini.snippets').setup({})
require('mini.starter').setup()
require('mini.statusline').setup()
require('mini.surround').setup()
require('mini.tabline').setup() 
---------------------------------------------------
local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = { 'n', 'x' }, keys = '<Leader>' },

    -- `[` and `]` keys
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = { 'n', 'x' }, keys = 'g' },

    -- Marks
    { mode = { 'n', 'x' }, keys = "'" },
    { mode = { 'n', 'x' }, keys = '`' },

    -- Registers
    { mode = { 'n', 'x' }, keys = '"' },
    { mode = { 'i', 'c' }, keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = { 'n', 'x' }, keys = 'z' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})
----------------------------------------------------
--- Colorscheme ---
MiniDeps.add('folke/tokyonight.nvim')
vim.cmd.colorscheme('tokyonight')
----------------------------------------------------
--- VimTex ---
MiniDeps.add('lervag/vimtex')
vim.g.vimtex_view_method = 'sioyek'
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_quickfix_ignore_filters = {
         "Underfull \\hbox",
	 "Overfull \\hbox",
         "LaTeX Warning: Unused global option(s):",
			}
----------------------------------------------------
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

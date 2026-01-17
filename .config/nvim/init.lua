require('options')
require('autocmds')
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
----------------------------------------------------
--- Colorscheme ---
MiniDeps.add('folke/tokyonight.nvim')
vim.cmd.colorscheme('tokyonight')
---------------------------------------------------
require('mini.icons').setup()
require('mini.statusline').setup()
require('mini.tabline').setup() 
require('mini.indentscope').setup()
require('mini.snippets').setup({})
require('mini.completion').setup({})
require('mini.pairs').setup({})
---------------------------------------------------
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
vim.keymap.set({'n'}, '<leader>tb', '<cmd>LspTexlabBuild<CR>', {desc = 'Compile LaTeX'})
vim.keymap.set({'n'}, '<leader>tv', '<cmd>LspTexlabForward<CR>', {desc = 'Forward View LaTeX'})

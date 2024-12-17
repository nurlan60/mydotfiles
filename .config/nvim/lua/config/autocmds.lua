-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local autocmd = vim.api.nvim_create_autocmd

-- Turn off paste mode when leaving insert
----------------
-- autocmd("InsertLeave", {
--   pattern = "*",
--   command = "set nopaste",
-- })

------------------------------------------------------
-- Disable the concealing in some file formats
-------------------
autocmd("FileType", {
  pattern = { "tex", "markdown" },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

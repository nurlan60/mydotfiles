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

---------------------------------------------------- 
-- Disable autoformat for toml files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "toml" },
  callback = function()
    vim.b.autoformat = false
  end,
})
------------------------------------------------------
-- Disable the concealing in some file formats
-------------------
autocmd("FileType", {
  pattern = { "tex", "markdown" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-------------------------------------------------------
-- Automatically switch keyboard layout
--------------

local layout_ids = {
  ["English (US)"] = 0,
  Russian = 1,
}

local get_current_layout = function()
  local file = io.popen("hyprctl devices -j | jq -r '.keyboards.[] | select(.main == true).active_keymap'")
  local output = file:read()
  file:close()
  return layout_ids[output]
end

local change_layout = function(layout)
  vim.fn.jobstart(string.format("hyprctl switchxkblayout current %s", layout))
end

local manage_layout = function(current_layout, layout_to_change)
  if current_layout ~= layout_to_change then
    change_layout(layout_to_change)
  end
end

local saved_layout = get_current_layout()

local NORMAL_LAYOUT = 0

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

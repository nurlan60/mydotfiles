
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

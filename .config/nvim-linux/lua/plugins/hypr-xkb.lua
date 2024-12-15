return {
  "nestermaks/hypr-xkb",
  event = { "VeryLazy" },
  opts = {
    -- write configs here
    -- or leave it empty for default values
    device = "at-translated-set-2-keyboard", -- Find the name of your keyboard device
    -- using terminal command: "hyprctl devices"
    normal_layout = "us", -- Choose the layout you use in normal mode
    check = false, -- OPTIONAL - This option is for speed optimization.
    -- You can slightly improve plugin startup speed by disabling this option,
    -- but it can help you troubleshoot configuration issues.
    lang_codes = { "us", "ru" }, -- OPTIONAL - This option is for speed optimization.
    -- Provide a list of your keyboard layout codes in the order you use them.
    -- You can find valid codes and names in /usr/share/X11/xkb/rules/base.lst.
    -- Without this option, the plugin will parse them automatically on every startup.
    layout_ids = {
      ["English (US)"] = 0,
      Russian = 1,
      normal = 0,
    }, -- OPTIONAL - This option is for speed optimization.
    -- Provide a list of key-value pairs, where the key is the name of the layout
    -- and the value is the index of your current layout set (starting from zero).
    -- Use brackets and quotes for keys if they have additional symbols in the layout name.
    -- You MUST include a key "normal" for the layout used in normal mode.
    -- You can find valid codes and names in /usr/share/X11/xkb/rules/base.lst.
    -- Without this option, the plugin will parse them automatically on every startup.
  },
}

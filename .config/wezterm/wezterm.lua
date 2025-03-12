local wezterm = require "wezterm"
local action = wezterm.action;

local config = {}
config.font = wezterm.font "Iosevka Nerd Font Mono"
config.color_scheme = 'Tokyo Night'
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
  left = 0,
  right = 2,
  top = 0,
  bottom = 0,
}

-- Wezterm's default scrolling feels quite finiky to me, so these just sets them to something
-- which is comfortable for me
config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'NONE',
    action = action.ScrollByLine(-5),
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'NONE',
    action = action.ScrollByLine(5),
  },
}

return config

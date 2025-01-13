local wezterm = require "wezterm"

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

return config

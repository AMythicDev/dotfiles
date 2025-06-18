local wezterm = require "wezterm"
local action = wezterm.action
local mux = wezterm.mux

wezterm.on('gui-attached', function(_)
  local workspace = mux.get_active_workspace()
  for _, window in ipairs(mux.all_windows()) do
    wezterm.log_info(window)
    if window:get_workspace() == workspace then
      window:gui_window():maximize()
    end
  end
end)

local config = wezterm.config_builder()
config.font = wezterm.font "JetBrainsMono Nerd Font"

config.color_scheme_dirs = { '/home/arijit/.config/wezterm/colors/' }
config.color_scheme = 'Tokyo Dark'
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

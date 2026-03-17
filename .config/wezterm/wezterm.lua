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

config.window_background_opacity = 0.8
config.color_scheme_dirs = { '/home/arijit/.config/wezterm/colors/' }
config.color_scheme = 'Rudv'
config.hide_tab_bar_if_only_one_tab = true
config.line_height = 1.3
config.font_size = 11
config.alternate_buffer_wheel_scroll_speed = 1
config.default_cursor_style = "SteadyBar"
config.keys = {
  { key = "Enter", mods = "SHIFT", action = wezterm.action { SendString = "\x1b\r" } },
}

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
    action = action.ScrollByLine(-3),
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'NONE',
    action = action.ScrollByLine(3),
  },
}

return config

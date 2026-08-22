local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Disables the title bar but keeps the resizable border
config.window_decorations = "RESIZE"

config.enable_tab_bar = false
config.window_frame = {
  -- Size of the border. You can use '1px', '2px', or cell sizes like '0.25cell'
  border_left_width = '2px',
  border_right_width = '2px',
  border_bottom_height = '2px',
  border_top_height = '2px',

  -- Change 'purple' to any hex color code like '#ff007f'
  border_left_color = '#E6884F',
  border_right_color = '#E6884F',
  border_bottom_color = '#E6884F',
  border_top_color = '#E6884F',
}
return config

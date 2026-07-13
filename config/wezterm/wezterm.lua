local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Disables the title bar but keeps the resizable border
config.window_decorations = "RESIZE"

config.enable_tab_bar = false

return config

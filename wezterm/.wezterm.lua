-- Pull in the wezterm API
local wezterm = require 'wezterm'
-- This will hold the configuration.
local config = wezterm.config_builder()

config.default_domain = 'WSL:Ubuntu'

config.color_scheme = "Catppuccin Macchiato"
config.automatically_reload_config = true
config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.default_cursor_style = "SteadyBar"
config.font = wezterm.font("JetBrains Mono NL Regular")
config.font_size = 12
config.max_fps = 240
config.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
  }
config.tab_and_split_indices_are_zero_based = true
 
-- and finally, return the configuration to wezterm
return config
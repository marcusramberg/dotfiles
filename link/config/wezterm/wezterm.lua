local wezterm = require 'wezterm'
return {
  adjust_window_size_when_changing_font_size = false,
  audible_bell = "Disabled",
  color_scheme = "Dracula+",
  font = wezterm.font("JetBrainsMono Nerd Font"),
  pane_focus_follows_mouse = true,
  window_decorations = "RESIZE",
  keys = {
    -- search for things that look like git hashes
    {key="G", mods="SUPER", action=wezterm.action{Search={Regex="[a-f0-9]{6,}"}}},
  },
}


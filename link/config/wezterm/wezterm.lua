local wezterm = require 'wezterm'
local keys = {
  {key="G", mods="SUPER", action=wezterm.action{Search={Regex="[a-f0-9]{6,}"}}},
  {key="V", mods="SUPER", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
  {key="S", mods="SUPER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
  {key="0", mods="CTRL", action=wezterm.action{ActivateTab=-1}},
}
for i = 1, 9 do
  table.insert(keys, {
      key=tostring(i),
      mods="CTRL",
      action=wezterm.action{ActivateTab=i-1},
    })
end
return {
  adjust_window_size_when_changing_font_size = false,
  audible_bell = "Disabled",
  color_scheme = "Dracula+",
  font = wezterm.font("JetBrainsMono Nerd Font"),
  pane_focus_follows_mouse = true,
  use_fancy_tab_bar = false,
  window_decorations = "RESIZE",
  keys = keys,
  mouse_bindings = {
    {
      event={Down={streak=1, button="Right"}},
      mods="NONE",
      action=wezterm.action{CopyTo="Clipboard"}
    },
    {
      event={Up={streak=1, button="Left"}},
      mods="CTRL",
      action="OpenLinkAtMouseCursor",
    },
  },
  hide_tab_bar_if_only_one_tab = true,
  inactive_pane_hsb = {
    saturation = 0.8,
    brightness = 0.6,
  }
}

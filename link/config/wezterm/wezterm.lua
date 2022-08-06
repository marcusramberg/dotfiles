local wezterm = require 'wezterm'
local colors = require 'colors'

wezterm.on("update-right-status", function(window, pane)
  -- "08:14"
  local time = wezterm.strftime("%H:%M ");
  window:set_right_status(wezterm.format({ {Text=wezterm.nerdfonts.mdi_clock .. " "..time},
  }));
end)

local keys = {
  {key="G", mods="SUPER", action=wezterm.action{Search={Regex="[a-f0-9]{6,}"}}},
  {key="V", mods="SUPER|ALT|CTRL|SHIFT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
  {key="S", mods="SUPER|ALT|CTRL|SHIFT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
  {key="H", mods="CTRL|SHIFT", action=wezterm.action{ActivatePaneDirection="Prev"}},
  {key="J", mods="CTRL|SHIFT", action=wezterm.action{ActivatePaneDirection="Up"}},
  {key="K", mods="CTRL|SHIFT", action=wezterm.action{ActivatePaneDirection="Down"}},
  {key="L", mods="CTRL|SHIFT", action=wezterm.action{ActivatePaneDirection="Next"}},
  {key="0", mods="CTRL", action=wezterm.action{ActivateTab=-1}},
}
for i = 1, 9 do
  table.insert(keys, {
      key=tostring(i),
      mods="CTRL",
      action=wezterm.action{ActivateTab=i-1},
    })
end
local config = {
  adjust_window_size_when_changing_font_size = false,
  audible_bell = "Disabled",
  -- color_scheme = "nord",
  font = wezterm.font("JetBrainsMono Nerd Font"),
  pane_focus_follows_mouse = false,
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
  },
  window_background_opacity = 0.95,
  colors = colors
}

-- Reduce fontsize to fix dpi issue on mArch
if wezterm.hostname() == "march" then
  config.font_size = 8.0
elseif wezterm.hostname() == "mbook" then
  config.font_size = 16.0
end

return config

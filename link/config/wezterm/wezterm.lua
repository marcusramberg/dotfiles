local wezterm = require("wezterm")

local pomodoro = 0

wezterm.on("update-right-status", function(window, _)
	local text = ""
	local now = math.floor(wezterm.strftime("%s") / 60)
	local since = now - pomodoro
	if since < 25 then
		if since >= 20 then
			text = "😴 " .. math.abs(25 - since) .. ":00"
		else
			text = "🍅 " .. math.abs(20 - since) .. ":00"
		end
	end
	-- Make it italic
	window:set_right_status(wezterm.format({
		{ Attribute = { Italic = true } },
		{ Text = text },
	}))
end)

local keys = {
	-- { key = "P", mods = "SUPER", action = wezterm.action.EmitEvent("start-pomodoro") },
	{
		key = "P",
		mods = "SUPER|ALT|CTRL|SHIFT",
		action = wezterm.action_callback(function(_, _)
			wezterm.log_info("Pomodoro started")
			pomodoro = math.floor(wezterm.strftime("%s") / 60)
		end),
	},
	{ key = "G", mods = "SUPER", action = wezterm.action({ Search = { Regex = "[a-f0-9]{6,}" } }) },
	{
		key = "V",
		mods = "SUPER|ALT|CTRL|SHIFT",
		action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
	},
	{
		key = "S",
		mods = "SUPER|ALT|CTRL|SHIFT",
		action = wezterm.action({ SplitHorizontal = {
			domain = "CurrentPaneDomain",
		} }),
	},
	{ key = "H", mods = "CTRL|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Prev" }) },
	{ key = "J", mods = "CTRL|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "K", mods = "CTRL|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "L", mods = "CTRL|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Next" }) },
	{ key = "0", mods = "CTRL", action = wezterm.action({ ActivateTab = -1 }) },
}
for i = 1, 9 do
	table.insert(keys, {
		key = tostring(i),
		mods = "CTRL",
		action = wezterm.action({ ActivateTab = i - 1 }),
	})
end
local config = {
	adjust_window_size_when_changing_font_size = false,
	audible_bell = "Disabled",
	-- color_scheme = "nord",
	check_for_updates = false,
	color_scheme = "tokyonight",
	default_gui_startup_args = { "connect", "unix" },
	font_rules = {
		{
			italic = true,
			font = wezterm.font("Iosevka Nerd Font", { italic = true }),
			-- font = wezterm.font("JetBrainsMono Nerd Font", {weight='ExtraLight', italic=true})
		},
	},
	font = wezterm.font("JetBrainsMono Nerd Font"),
	hide_tab_bar_if_only_one_tab = true,
	inactive_pane_hsb = {
		saturation = 0.7,
		brightness = 0.7,
	},
	keys = keys,
	pane_focus_follows_mouse = false,
	mouse_bindings = {
		{
			event = { Down = { streak = 1, button = "Right" } },
			mods = "NONE",
			action = wezterm.action({ CopyTo = "Clipboard" }),
		},
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = "OpenLinkAtMouseCursor",
		},
	},
	ssh_domains = {
		{
			name = "mbook",
			remote_address = "mbook",
			username = "marcus",
		},
		{
			name = "march",
			remote_address = "march",
			username = "marcus",
		},
	},
	unix_domains = {
		{
			name = "unix",
		},
	},
	use_fancy_tab_bar = false,
	window_background_opacity = 0.95,
	window_decorations = "RESIZE",
}

-- Reduce fontsize to fix dpi issue on mArch
if wezterm.hostname() == "march" then
	config.font_size = 8.0
elseif wezterm.hostname() == "mbook" then
	config.font_size = 16.0
end

return config

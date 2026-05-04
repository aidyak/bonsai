-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.automatically_reload_config = true

config.font = wezterm.font_with_fallback({
	"RobotoMono Nerd Font",
	"HackGen Console NF",
})
config.font_size = 14

config.window_frame = {
	inactive_titlebar_bg = "none",
	active_titlebar_bg = "none",
	inactive_titlebar_fg = "#44475A",
	active_titlebar_fg = "#F8F8F2",
	inactive_titlebar_border_bottom = "#282A36",
	active_titlebar_border_bottom = "#282A36",
	button_fg = "#44475A",
	button_bg = "#282A36",
	button_hover_fg = "#F8F8F2",
	button_hover_bg = "#282A36",
}

config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#5c6d74"
	local foreground = "#FFFFFF"

	if tab.is_active then
		background = "#ae8b2d"
		foreground = "#FFFFFF"
	end

	local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

	return {
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
	}
end)

-- ベルを止める
config.audible_bell = "Disabled"

config.scrollback_lines = 100000000

-- imeでの入力を無効化する
config.use_ime = true

config.exit_behavior = "CloseOnCleanExit"

-- For example, changing the color scheme:
config.color_scheme = "Frontend Fun Forrest (Gogh)"

local color_schemes = {
	"Dracula+",
	"Builtin Solarized Dark",
	"Batman",
	"Atelier Cave Light",
	"BirdsOfParadise",
	"Brogrammer (base16)",
	"Frontend Fun Forrest (Gogh)",
}

local function next_color_scheme(current)
	for i, name in ipairs(color_schemes) do
		if name == current then
			return color_schemes[(i % #color_schemes) + 1]
		end
	end
	return color_schemes[1]
end

wezterm.on("toggle-color-scheme", function(window, _)
	local overrides = window:get_config_overrides() or {}
	local current = overrides.color_scheme or config.color_scheme
	overrides.color_scheme = next_color_scheme(current)
	window:set_config_overrides(overrides)
end)

-- prefixの設定
config.leader = {
	key = "a",
	mods = "CTRL",
	timeout_milliseconds = 2000,
}

-- splitting
config.keys = {
	-- splitting
	{
		mods = "LEADER",
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "|",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		mods = "LEADER",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		mods = "LEADER",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		mods = "LEADER",
		key = "t",
		action = wezterm.action.EmitEvent("toggle-color-scheme"),
	},
}
-- and finally, return the configuration to wezterm
return config

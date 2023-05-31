--       █████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗
--      ██╔══██╗██║    ██║██╔════╝██╔════╝██╔═══██╗████╗ ████║██╔════╝
--      ███████║██║ █╗ ██║█████╗  ███████╗██║   ██║██╔████╔██║█████╗
--      ██╔══██║██║███╗██║██╔══╝  ╚════██║██║   ██║██║╚██╔╝██║██╔══╝
--      ██║  ██║╚███╔███╔╝███████╗███████║╚██████╔╝██║ ╚═╝ ██║███████╗
--      ╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝


-- {{{ Required libraries

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local gears         = require("gears")
local awful         = require("awful")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup")
local sharedtags    = require("sharedtags")
local mytable       = awful.util.table or gears.table -- 4.{0,1} compatibility
require("awful.autofocus")
require("awful.hotkeys_popup.keys")


-- }}}

-- {{{ Error handling

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify {
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors
	}
end

-- Handle runtime errors after startup
do
	local in_error = false

	awesome.connect_signal("debug::error", function(err)
		if in_error then return end

		in_error = true

		naughty.notify {
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err)
		}

		in_error = false
	end)
end

-- }}}


-- {{{ Variable definitions

local themes                           = {
	"powerarrow-gruvbox", -- 1
}

local theme                            = themes[1]
local theme_config                     = string.format("%s/.config/awesome/themes/%s/", os.getenv("HOME"), theme)
local altkey                           = "Mod1"
local modkey                           = "Mod4"
local terminal                         = "kitty"
local vi_focus                         = false -- vi-like client focus https://github.com/lcpz/awesome-copycats/issues/275
local cycle_prev                       = true  -- cycle with only the previously focused client or all https://github.com/lcpz/awesome-copycats/issues/274
local editor                           = os.getenv("EDITOR") or "nvim"
local browser                          = "firefox"

local run_on_start_up                  = {
	"picom --config " .. theme_config .. "picom.conf",
	"snixembed",
	"nm-applet",
}

awful.util.terminal                    = terminal
awful.util.tagnames                    = {}
awful.layout.layouts                   = {
	awful.layout.suit.tile.right,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.floating,
	--awful.layout.suit.tile,
	--awful.layout.suit.tile.left,
	--awful.layout.suit.tile.bottom,
	--awful.layout.suit.tile.top,
	--awful.layout.suit.fair,
	--awful.layout.suit.fair.horizontal,
	--awful.layout.suit.spiral,
	--awful.layout.suit.spiral.dwindle,
	--awful.layout.suit.max,
	--awful.layout.suit.max.fullscreen,
	--awful.layout.suit.magnifier,
	--awful.layout.suit.corner.nw,
	--awful.layout.suit.corner.ne,
	--awful.layout.suit.corner.sw,
	--awful.layout.suit.corner.se,
	--lain.layout.cascade,
	--lain.layout.cascade.tile,
	--lain.layout.centerwork,
	--lain.layout.centerwork.horizontal,
	--lain.layout.termfair,
	--lain.layout.termfair.center
}

-- Shared tags
local tags                             = sharedtags({
	{ name = "", layout = awful.layout.layouts[1] },
	{ name = "", layout = awful.layout.layouts[1] },
	{ name = "", layout = awful.layout.layouts[1] },
	{ name = "", layout = awful.layout.layouts[1] },
	{ name = "", layout = awful.layout.layouts[1] },
	{ name = "", layout = awful.layout.layouts[1] },
	{ name = "", layout = awful.layout.layouts[1] },
	{ name = "", layout = awful.layout.layouts[1] },
	{ name = "", layout = awful.layout.layouts[1] },
	{ name = "", layout = awful.layout.layouts[1] },
	{ name = "", layout = awful.layout.layouts[1] },
	{ name = "", layout = awful.layout.layouts[1] },
})

local tagKeys                          = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "minus", "equal" }

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

awful.util.taglist_buttons             = mytable.join(
	awful.button({}, 1, function(t) t:view_only() end),
	awful.button({ altkey }, 1, function(t)
		if client.focus then client.focus:move_to_tag(t) end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ altkey }, 3, function(t)
		if client.focus then client.focus:toggle_tag(t) end
	end),
	awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons            = mytable.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function() awful.client.focus.byidx(1) end),
	awful.button({}, 5, function() awful.client.focus.byidx(-1) end)
)

--beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))
beautiful.init(theme_config .. "/theme.lua")
beautiful.systray_icon_spacing = 4;

-- }}}

-- {{{ Bling

local bling                    = require("bling")
bling.module.flash_focus.enable()

-- }}}

-- {{{ Autostart windowless processes

-- This function will run once every time Awesome is started
--local function run_once(cmd_arr)
--	for _, cmd in ipairs(cmd_arr) do
--		awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
--	end
--end

for _, app in ipairs(run_on_start_up) do
	local findme = app
	local firstspace = app:find(" ")
	if firstspace then
		findme = app:sub(0, firstspace - 1)
	end
	-- pipe commands to bash to allow command to be shell agnostic
	awful.spawn.with_shell(string.format("echo 'pgrep -u $USER -x %s > /dev/null || (%s)' | bash -", findme, app), false)
end


awful.spawn.with_shell(
	"pkill monitor-sensor; auto-rotate 'eDP' 'Wacom HID 52AE Pen Pen (0x802026b9)' 'Wacom HID 52AE Finger'")


-- {{{ Menu

-- Create a launcher widget and a main menu
local myawesomemenu = {
	{ "Hotkeys",     function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
	{ "Manual",      string.format("%s -e man awesome", terminal) },
	{ "Edit config", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
	{ "Restart",     awesome.restart },
	{ "Quit",        function() awesome.quit() end },
}

local utilitymenu = {
	{ "Bluetooth",        function() awful.spawn.with_shell('kitty -e bluetuith') end },
	{ "Virtual keyboard", function() awful.spawn.with_shell('pgrep onboard && pkill onboard || onboard') end },
};


awful.util.mymainmenu = freedesktop.menu.build {
	before = {
		{ "Awesome",   myawesomemenu, beautiful.awesome_icon },
		{ "Utilities", utilitymenu },
		-- other triads can be put here
	},
	after = {
		{ "Open terminal", terminal },
		-- other triads can be put here
	}
}

-- Hide the menu when the mouse leaves it
awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function()
	if not awful.util.mymainmenu.active_child or
			(awful.util.mymainmenu.wibox ~= mouse.current_wibox and
				awful.util.mymainmenu.active_child.wibox ~= mouse.current_wibox) then
		awful.util.mymainmenu:hide()
	else
		awful.util.mymainmenu.active_child.wibox:connect_signal("mouse::leave",
			function()
				if awful.util.mymainmenu.wibox ~= mouse.current_wibox then
					awful.util.mymainmenu:hide()
				end
			end)
	end
end)

awful.menu.client_list():connect_signal("mouse::leave,", function()
	if awful.menu.client_list() then
		awful.menu.client_list():hide()
	end
end)


-- }}}

-- {{{ Screen

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function(s)
	local only_one = #s.tiled_clients == 1
	for _, c in pairs(s.clients) do
		if only_one and not c.floating or c.maximized or c.fullscreen then
			c.border_width = 0
		else
			c.border_width = beautiful.border_width
		end
	end
end)

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)

-- }}}

-- {{{ Mouse bindings

root.buttons(mytable.join(
	awful.button({}, 1, function() awful.util.mymainmenu:toggle() end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))

-- }}}

-- {{{ Key bindings

globalkeys = mytable.join(
-- Destroy all notifications
	awful.key({ "Control", }, "space", function() naughty.destroy_all_notifications() end,
		{ description = "destroy all notifications", group = "hotkeys" }),

	-- Suspend/resume notifications
	awful.key({ altkey, "Control" }, "space", function()
			naughty.toggle()
		end,
		{ description = "suspend/resume notifications", group = "hotkeys" }),

	-- Take a screenshot
	-- https://github.com/lcpz/dots/blob/master/bin/screenshot
	awful.key({ modkey }, "p", function() os.execute("screenshot") end,
		{ description = "take a screenshot", group = "hotkeys" }),

	-- X screen locker
	awful.key({ modkey, "Control" }, "l", function() os.execute(scrlocker) end,
		{ description = "lock screen", group = "hotkeys" }),

	-- Show help
	awful.key({ altkey, }, "s", hotkeys_popup.show_help,
		{ description = "show help", group = "awesome" }),

	-- Tag browsing
	awful.key({ altkey, }, "[", awful.tag.viewprev,
		{ description = "view previous", group = "tag" }),
	awful.key({ altkey, }, "]", awful.tag.viewnext,
		{ description = "view next", group = "tag" }),
	awful.key({ altkey, }, "Escape", awful.tag.history.restore,
		{ description = "go back", group = "tag" }),

	-- Non-empty tag browsing
	awful.key({ modkey }, "Left", function() lain.util.tag_view_nonempty(-1) end,
		{ description = "view  previous nonempty", group = "tag" }),
	awful.key({ modkey }, "Right", function() lain.util.tag_view_nonempty(1) end,
		{ description = "view  previous nonempty", group = "tag" }),

	-- Default client focus
	awful.key({ modkey, }, "j",
		function()
			awful.client.focus.byidx(1)
		end,
		{ description = "focus next by index", group = "client" }
	),
	awful.key({ modkey, }, "k",
		function()
			awful.client.focus.byidx(-1)
		end,
		{ description = "focus previous by index", group = "client" }
	),

	-- By-direction client focus
	awful.key({ altkey }, "j",
		function()
			awful.client.focus.global_bydirection("down")
			if client.focus then client.focus:raise() end
		end,
		{ description = "focus down", group = "client" }),
	awful.key({ altkey }, "k",
		function()
			awful.client.focus.global_bydirection("up")
			if client.focus then client.focus:raise() end
		end,
		{ description = "focus up", group = "client" }),
	awful.key({ altkey }, "h",
		function()
			awful.client.focus.global_bydirection("left")
			if client.focus then client.focus:raise() end
		end,
		{ description = "focus left", group = "client" }),
	awful.key({ altkey }, "l",
		function()
			awful.client.focus.global_bydirection("right")
			if client.focus then client.focus:raise() end
		end,
		{ description = "focus right", group = "client" }),

	-- Menu
	awful.key({ altkey, }, "w", function() awful.util.mymainmenu:show() end,
		{ description = "show main menu", group = "awesome" }),

	-- Layout manipulation
	awful.key({ altkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
		{ description = "swap with next client by index", group = "client" }),
	awful.key({ altkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
		{ description = "swap with previous client by index", group = "client" }),
	awful.key({ altkey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
		{ description = "focus the next screen", group = "screen" }),
	awful.key({ altkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
		{ description = "focus the previous screen", group = "screen" }),
	awful.key({ altkey, }, "u", awful.client.urgent.jumpto,
		{ description = "jump to urgent client", group = "client" }),
	awful.key({ altkey, }, "Tab",
		function()
			if cycle_prev then
				awful.client.focus.history.previous()
			else
				awful.client.focus.byidx(-1)
			end
			if client.focus then
				client.focus:raise()
			end
		end,
		{ description = "cycle with previous/go back", group = "client" }),

	-- Show/hide wibox
	awful.key({ altkey, }, "p", function()
			for s in screen do
				s.mywibox.visible = not s.mywibox.visible
				if s.mybottomwibox then
					s.mybottomwibox.visible = not s.mybottomwibox.visible
				end
			end
		end,
		{ description = "toggle wibox", group = "awesome" }),

	-- On-the-fly useless gaps change
	awful.key({ modkey, "Control" }, "+", function() lain.util.useless_gaps_resize(1) end,
		{ description = "increment useless gaps", group = "tag" }),
	awful.key({ modkey, "Control" }, "-", function() lain.util.useless_gaps_resize(-1) end,
		{ description = "decrement useless gaps", group = "tag" }),

	-- Dynamic tagging
	awful.key({ altkey, "Shift" }, "n", function() lain.util.add_tag() end,
		{ description = "add new tag", group = "tag" }),
	awful.key({ altkey, "Shift" }, "r", function() lain.util.rename_tag() end,
		{ description = "rename tag", group = "tag" }),
	awful.key({ altkey, "Shift" }, "Left", function() lain.util.move_tag(-1) end,
		{ description = "move tag to the left", group = "tag" }),
	awful.key({ altkey, "Shift" }, "Right", function() lain.util.move_tag(1) end,
		{ description = "move tag to the right", group = "tag" }),
	awful.key({ altkey, "Shift" }, "d", function() lain.util.delete_tag() end,
		{ description = "delete tag", group = "tag" }),

	-- Standard program
	awful.key({ altkey, }, "Return", function() awful.spawn(terminal) end,
		{ description = "open a terminal", group = "launcher" }),
	awful.key({ altkey, "Control" }, "r", awesome.restart,
		{ description = "reload awesome", group = "awesome" }),
	awful.key({ altkey, "Shift" }, "q", awesome.quit,
		{ description = "quit awesome", group = "awesome" }),
	awful.key({ altkey, modkey }, "l", function() awful.tag.incmwfact(0.05) end,
		{ description = "increase master width factor", group = "layout" }),
	awful.key({ altkey, modkey }, "h", function() awful.tag.incmwfact(-0.05) end,
		{ description = "decrease master width factor", group = "layout" }),
	awful.key({ altkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
		{ description = "increase the number of master clients", group = "layout" }),
	awful.key({ altkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
		{ description = "decrease the number of master clients", group = "layout" }),
	awful.key({ altkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end,
		{ description = "increase the number of columns", group = "layout" }),
	awful.key({ altkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end,
		{ description = "decrease the number of columns", group = "layout" }),
	awful.key({ altkey, }, "space", function() awful.layout.inc(1) end,
		{ description = "select next", group = "layout" }),
	awful.key({ altkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
		{ description = "select previous", group = "layout" }),

	awful.key({ altkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),

	-- Dropdown application
	awful.key({ altkey, }, "z", function() awful.screen.focused().quake:toggle() end,
		{ description = "dropdown application", group = "launcher" }),

	-- Widgets popups
	awful.key({ modkey, }, "c", function() if beautiful.cal then beautiful.cal.show(7) end end,
		{ description = "show calendar", group = "widgets" }),
	awful.key({ modkey, }, "h", function() if beautiful.fs then beautiful.fs.show(7) end end,
		{ description = "show filesystem", group = "widgets" }),

	-- Screen brightness
	awful.key({}, "XF86MonBrightnessUp", function() os.execute("light -A 10") end,
		{ description = "+10%", group = "hotkeys" }),
	awful.key({}, "XF86MonBrightnessDown", function() os.execute("light -U 10") end,
		{ description = "-10%", group = "hotkeys" }),

	-- ALSA volume control
	awful.key({ modkey }, "Up",
		function()
			os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel))
			beautiful.volume.update()
		end,
		{ description = "volume up", group = "hotkeys" }),
	awful.key({ modkey }, "Down",
		function()
			os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
			beautiful.volume.update()
		end,
		{ description = "volume down", group = "hotkeys" }),
	awful.key({ modkey }, "m",
		function()
			os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
			beautiful.volume.update()
		end,
		{ description = "toggle mute", group = "hotkeys" }),
	awful.key({ modkey, "Control" }, "m",
		function()
			os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
			beautiful.volume.update()
		end,
		{ description = "volume 100%", group = "hotkeys" }),
	awful.key({ modkey, "Control" }, "0",
		function()
			os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
			beautiful.volume.update()
		end,
		{ description = "volume 0%", group = "hotkeys" }),

	-- MPD control
	awful.key({ modkey, "Control" }, "Up",
		function()
			naughty.destroy_all_notifications()
			os.execute("mpc toggle")
			beautiful.mpd.update()
		end,
		{ description = "mpc toggle", group = "widgets" }),
	awful.key({ modkey, "Control" }, "Down",
		function()
			os.execute("mpc stop")
			beautiful.mpd.update()
		end,
		{ description = "mpc stop", group = "widgets" }),
	awful.key({ modkey, "Control" }, "Left",
		function()
			naughty.destroy_all_notifications()
			os.execute("mpc prev")
			beautiful.mpd.update()
		end,
		{ description = "mpc prev", group = "widgets" }),
	awful.key({ modkey, "Control" }, "Right",
		function()
			naughty.destroy_all_notifications()
			os.execute("mpc next")
			beautiful.mpd.update()
		end,
		{ description = "mpc next", group = "widgets" }),
	awful.key({ modkey }, "0",
		function()
			local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
			if beautiful.mpd.timer.started then
				beautiful.mpd.timer:stop()
				common.text = common.text .. lain.util.markup.bold("OFF")
			else
				beautiful.mpd.timer:start()
				common.text = common.text .. lain.util.markup.bold("ON")
			end
			naughty.notify(common)
		end,
		{ description = "mpc on/off", group = "widgets" }),

	-- Copy primary to clipboard (terminals to gtk)
	awful.key({ altkey }, "c", function() awful.spawn.with_shell("xsel | xsel -i -b") end,
		{ description = "copy terminal to gtk", group = "hotkeys" }),
	-- Copy clipboard to primary (gtk to terminals)
	awful.key({ altkey }, "v", function() awful.spawn.with_shell("xsel -b | xsel") end,
		{ description = "copy gtk to terminal", group = "hotkeys" }),

	-- User programs
	awful.key({ altkey }, "b", function() awful.spawn(browser) end,
		{ description = "run browser", group = "launcher" }),

	--	awful.key({ altkey }, "m", function(c)
	--		awful.spawn.raise_or_spawn('kitty --session "sessions/ncmpcpp-playlist.conf"', nil, function(c)
	--			if c.class == "playlist" then
	--				client.focus = c
	--				return true
	--			end
	--			return false
	--		end)
	--	end, { description = "ncmpcpp playlist", group = "command window" }),

	awful.key({ altkey, "Shift" }, "m", function(c)
		awful.spawn.raise_or_spawn('kitty --session "sessions/ncmpcpp-library.conf"', nil, function(c)
			if c.class == "library" then
				client.focus = c
				return true
			end
			return false
		end)
	end, { description = "ncmpcpp library", group = "command window" }),

	awful.key({ altkey }, "i", function(c)
		awful.spawn.raise_or_spawn('kitty --session "sessions/pulsemixer.conf"', nil, function(c)
			if c.class == "pulsemixerj" then
				client.focus = c
				return true
			end
			return false
		end)
	end, { description = "pulsemixer", group = "command window" }),

	-- rofi
	awful.key({ altkey }, "d",
		function()
			os.execute(string.format("rofi -show drun -theme %s/.config/rofi/launcher/config.rasi", os.getenv("HOME")))
		end,
		{ description = "launch rofi", group = "launcher" }),

	-- Default
	--[[ Menubar
    awful.key({ altkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),
    --]]
	--[[ dmenu
    awful.key({ altkey }, "x", function ()
            os.execute(string.format("dmenu_run -i -fn 'Monospace' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
            beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))
        end,
        {description = "show dmenu", group = "launcher"}),
    --]]
	-- modernatively use rofi, a dmenu-like application with more features
	-- check https://github.com/DaveDavenport/rofi for more details
	--

	-- Prompt
	awful.key({ altkey }, "r", function() awful.screen.focused().mypromptbox:run() end,
		{ description = "run prompt", group = "launcher" }),

	awful.key({ altkey }, "x",
		function()
			awful.prompt.run {
				prompt       = "Run Lua code: ",
				textbox      = awful.screen.focused().mypromptbox.widget,
				exe_callback = awful.util.eval,
				history_path = awful.util.get_cache_dir() .. "/history_eval"
			}
		end,
		{ description = "lua execute prompt", group = "awesome" })
--]]

)

clientkeys = mytable.join(
	awful.key({ modkey, "Shift" }, "m", lain.util.magnify_client,
		{ description = "magnify client", group = "client" }),
	awful.key({ altkey, }, "f",
		function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
		{ description = "toggle fullscreen", group = "client" }),
	awful.key({ altkey, }, "q", function(c) c:kill() end,
		{ description = "close", group = "client" }),
	awful.key({ altkey, "Control" }, "f", awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }),
	awful.key({ altkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
		{ description = "move to master", group = "client" }),
	awful.key({ altkey, }, "o", function(c) c:move_to_screen() end,
		{ description = "move to screen", group = "client" }),
	awful.key({ altkey, }, "t", function(c) c.ontop = not c.ontop end,
		{ description = "toggle keep on top", group = "client" }),
	--awful.key({ altkey, }, "n",
	--	function(c)
	--		-- The client currently has the input focus, so it cannot be
	--		-- minimized, since minimized clients can't have the focus.
	--		c.minimized = true
	--	end,
	--	{ description = "minimize", group = "client" }),
	awful.key({ altkey, }, "m",
		function(c)
			c.maximized = not c.maximized
			c:raise()
		end,
		{ description = "(un)maximize", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.

for i, t in ipairs(tagKeys) do
	globalkeys = mytable.join(globalkeys,
		-- View tag only.
		awful.key({ altkey }, t,
			function()
				local screen = awful.screen.focused()
				local tag = tags[i]
				if tag then
					sharedtags.viewonly(tag, screen)
				end
			end,
			{ description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		awful.key({ altkey, "Control" }, t,
			function()
				local screen = awful.screen.focused()
				local tag = tags[i]
				if tag then
					sharedtags.viewtoggle(tag, screen)
				end
			end,
			{ description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ altkey, "Shift" }, t,
			function()
				if client.focus then
					local tag = tags[i]
					if tag then
						client.focus:move_to_tag(tag)
						local screen = awful.screen.focused()
						sharedtags.viewonly(tag, screen)
					end
				end
			end,
			{ description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ altkey, "Control", "Shift" }, t,
			function()
				if client.focus then
					local tag = tags[i]
					if tag then
						client.focus:toggle_tag(tag)
					end
				end
			end,
			{ description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

clientbuttons = mytable.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ altkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ altkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)

-- }}}

-- {{{ Rules

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			callback = awful.client.setslave,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
			size_hints_honor = false
		}
	},

	-- Floating clients.
	{
		rule_any = {
			class = {
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"playlist",
				"library",
				"processes",
				"pulsemixer",
			},
			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up",    -- e.g. Google Chrome's (detached) Developer Tools.
			}
		},
		properties = { floating = true }
	},

	-- Add titlebars to normal clients and dialogs
	{
		rule_any = { type = { "normal", "dialog" }
		},
		properties = { titlebars_enabled = false }
	},

	-- Steam
	{
		rule_any = {
			instance = {
				"Steam",
			},
		},
		properties = {
			floating = false,
			tag = tags[8]
		}
	},

	-- Keepass
	{
		rule_any = {
			instance = {
				"keepassxc"
			},
		},
		properties = {
			floating = false,
			tag = tags[9]
		}
	},

	-- WORK APPS
	-- Edge
	{
		rule_any = {
			instance = {
				"microsoft-edge",
			},
		},
		properties = {
			floating = false,
			tag = tags[10]
		}
	},

	-- Teams
	{
		rule_any = {
			instance = {
				"crx__cifhbcnohmdccbgoicgdjpfamggdegmo",
			},
		},
		properties = {
			floating = false,
			tag = tags[11]
		}
	},

	-- Outlook
	{
		rule_any = {
			instance = {
				"crx__pkooggnaalmfkidjmlhoelhdllpphaga"
			},
		},
		properties = {
			floating = false,
			tag = tags[12]
		}
	},

	-- Onboard
	{
		rule_any = {
			class = {
				"Onboard"
			},
		},
		properties = { focusable = false }
	},

	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- { rule = { class = "Firefox" },
	--   properties = { screen = 1, tag = "2" } },

	{
		rule = { class = "krita" },
		properties = { tag = tags[3] }
	},
}

-- }}}

-- {{{ Signals

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup
			and not c.size_hints.user_position
			and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- Custom
	if beautiful.titlebar_fun then
		beautiful.titlebar_fun(c)
		return
	end

	-- Default
	-- buttons for the titlebar
	local buttons = mytable.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c, { size = 16 }):setup {
		{
			-- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout  = wibox.layout.fixed.horizontal
		},
		{
			-- Middle
			{
				-- Title
				align  = "center",
				widget = awful.titlebar.widget.titlewidget(c)
			},
			buttons = buttons,
			layout  = wibox.layout.flex.horizontal
		},
		{
			-- Right
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal()
		},
		layout = wibox.layout.align.horizontal
	}
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = vi_focus })
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- switch to parent after closing child window
local function backham()
	local s = awful.screen.focused()
	local c = awful.client.focus.history.get(s, 0)
	if c then
		client.focus = c
		c:raise()
	end
end

-- attach to minimized state
client.connect_signal("property::minimized", backham)
-- attach to closed state
client.connect_signal("unmanage", backham)
-- ensure there is always a selected client during tag switching or logins
tag.connect_signal("property::selected", backham)

-- }}}


--- Enable for lower memory consumption
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
gears.timer({
	timeout = 5,
	autostart = true,
	call_now = true,
	callback = function()
		collectgarbage("collect")
	end,
})

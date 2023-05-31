--[[

     Powerarrow Gruvbox Awesome WM theme (by arclight443)
		 Based on Powerarrow-Dark (by lcpz)

--]]
local gears                                     = require("gears")
local lain                                      = require("lain")
local brightness_widget                         = require("awesome-wm-widgets.brightness-widget.brightness")
local awful                                     = require("awful")
local wibox                                     = require("wibox")
local naughty                                   = require("naughty")
local dpi                                       = require("beautiful.xresources").apply_dpi

local os                                        = os
local my_table                                  = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow-gruvbox"
theme.wallpaper                                 = theme.dir .. "/wall.png"
theme.font                                      = "FiraCode Nerd Font Mono 10"
theme.fg_normal                                 = "#D4BE98"
theme.fg_focus                                  = "#EA6962"
theme.fg_urgent                                 = "#D3869B"
theme.bg_normal                                 = "#282828"
theme.bg_focus                                  = "#3C3836"
theme.bg_urgent                                 = "#1A1A1A"
theme.bg_transparent                            = "#FFFFFF00"
theme.border_width                              = dpi(1)
theme.border_normal                             = "#5A524C"
theme.border_focus                              = "#D4BE98"
theme.border_marked                             = "#7DAEA3"
theme.tasklist_bg_focus                         = "#1A1A1A"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.menu_font                                 = "Iosevka Nerd Font Mono 11"
theme.taglist_font                              = "FiraCode Nerd Font Mono 14"
theme.taglist_spacing                           = dpi(1)
theme.menu_height                               = dpi(30)
theme.menu_width                                = dpi(160)
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
theme.widget_battery                            = theme.dir .. "/icons/battery.png"
theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_vol                                = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = dpi(0)
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

local markup                                    = lain.util.markup
local separators                                = lain.util.separators

local keyboardlayout                            = awful.widget.keyboardlayout:new()

-- Textclock
local clockicon                                 = wibox.widget.imagebox(theme.widget_clock)
local clock                                     = awful.widget.watch(
	"date +'%a %d %b %R'", 60,
	function(widget, stdout)
		widget:set_markup(" " .. markup.font(theme.font, stdout))
	end
)

-- Calendar
theme.cal                                       = lain.widget.cal({
	attach_to = { clock },
	notification_preset = {
		font = "Iosevka Nerd Font Mono 10",
		fg   = theme.fg_normal,
		bg   = theme.bg_normal
	}
})

-- MPD
local mpdprev                                   = wibox.widget {
	markup = markup.font("FiraCode Nerd Font 12", markup(theme.fg_normal, " 玲 ")),
	widget = wibox.widget.textbox
}

local mpdnext                                   = wibox.widget {
	markup = markup.font("FiraCode Nerd Font 12", markup(theme.fg_normal, " 怜 ")),
	widget = wibox.widget.textbox
}

local mpdinterface                              = wibox.widget {
	markup = markup.font("FiraCode Nerd Font 12", markup(theme.fg_normal, " ﱘ ")),
	widget = wibox.widget.textbox
}

local mpdtoggle                                 = wibox.widget {
	markup = markup.font("FiraCode Nerd Font 7", markup(theme.fg_normal, "   ")),
	widget = wibox.widget.textbox
}

local mpdstop                                   = wibox.widget {
	markup = markup.font("FiraCode Nerd Font 7", markup(theme.fg_normal, "  ")),
	widget = wibox.widget.textbox
}

mpdprev:buttons(awful.util.table.join(awful.button({}, 1, function()
	naughty.destroy_all_notifications()
	os.execute("mpc prev")
end)))

mpdnext:buttons(awful.util.table.join(awful.button({}, 1, function()
	naughty.destroy_all_notifications()
	os.execute("mpc next")
end)))

mpdtoggle:buttons(awful.util.table.join(awful.button({}, 1, function() os.execute("mpc toggle") end)))
mpdstop:buttons(awful.util.table.join(awful.button({}, 1, function() os.execute("mpc stop") end)))
mpdinterface:buttons(awful.util.table.join(awful.button({}, 1, function()
	awful.spawn.raise_or_spawn('kitty --session "sessions/ncmpcpp-playlist.conf"', nil, function(c)
		if c.class == "playlist" then
			client.focus = c
			return true
		end
		return false
	end)
end)))

theme.mpd = lain.widget.mpd({
	settings = function()
		if mpd_now.state == "play" then
			mpdinterface:set_markup(markup.font("FiraCode Nerd Font 12", markup("#EA6962", " ﱘ ")))
			mpdtoggle:set_markup(markup.font("FiraCode Nerd Font 7", markup(theme.fg_normal, "   ")))
		elseif mpd_now.state == "pause" then
			mpdinterface:set_markup(markup.font("FiraCode Nerd Font 12", markup("#EA6962", " ﱙ ")))
			mpdtoggle:set_markup(markup.font("FiraCode Nerd Font 7", markup(theme.fg_normal, "   ")))
		else
			mpdinterface:set_markup(markup.font("FiraCode Nerd Font 12", markup(theme.fg_normal, " ﱙ ")))
			mpdtoggle:set_markup(markup.font("FiraCode Nerd Font 7", markup(theme.fg_normal, "   ")))
		end
	end
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
	settings = function()
		widget:set_markup(markup.font(theme.font, " " .. mem_now.used .. "MiB "))
	end
})

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
	settings = function()
		widget:set_markup(markup.font(theme.font, " " .. cpu_now.usage .. "% "))
	end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
	settings = function()
		widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
	end
})

-- / fs
local fsicon = wibox.widget.imagebox(theme.widget_hdd)
theme.fs = lain.widget.fs({
	notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "FiraCode Nerd Font Mono 10" },
	settings = function()
		widget:set_markup(markup.font(theme.font, " " .. fs_now["/"].percentage .. "% "))
	end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat({
	settings = function()
		if bat_now.status and bat_now.status ~= "N/A" then
			if bat_now.ac_status == 1 then
				baticon:set_image(theme.widget_ac)
			elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
				baticon:set_image(theme.widget_battery_empty)
			elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
				baticon:set_image(theme.widget_battery_low)
			else
				baticon:set_image(theme.widget_battery)
			end
			widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
		else
			widget:set_markup(markup.font(theme.font, " AC "))
			baticon:set_image(theme.widget_ac)
		end
	end
})

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
	settings = function()
		if volume_now.status == "off" then
			volicon:set_image(theme.widget_vol_mute)
		elseif tonumber(volume_now.level) == 0 then
			volicon:set_image(theme.widget_vol_no)
		elseif tonumber(volume_now.level) <= 50 then
			volicon:set_image(theme.widget_vol_low)
		else
			volicon:set_image(theme.widget_vol)
		end

		widget:set_markup(markup.font(theme.font, " " .. volume_now.level .. "% "))
	end
})
theme.volume.widget:buttons(awful.util.table.join(
	awful.button({}, 4, function()
		awful.util.spawn("amixer set Master 1%+")
		theme.volume.update()
	end),
	awful.button({}, 5, function()
		awful.util.spawn("amixer set Master 1%-")
		theme.volume.update()
	end)
))

-- Net
local net = lain.widget.net({
	notify = "off",
	units = 1024 ^ 2,
	settings = function()
		widget:set_markup(markup.font(theme.font,
			markup("#A9B665", "  " .. net_now.received .. "MB ")
			.. " " ..
			markup("#7DAEA3", " " .. net_now.sent .. "MB ")))
	end
})

-- Bluetooth
local bluetooth = wibox.widget {
	markup = markup.font("FiraCode Nerd Font 10", markup(theme.fg_normal, " ")),
	widget = wibox.widget.textbox
}
bluetooth:buttons(awful.util.table.join(
	awful.button({}, 1, function() awful.spawn("kitty -e bluetuith") end)
))

-- Awesome Menu
local awesomemenu = wibox.widget {
	markup = markup.font("FiraCode Nerd Font 14", markup("#7DAEA3", "  ")),
	widget = wibox.widget.textbox
}
awesomemenu:buttons(awful.util.table.join(
	awful.button({}, 1, function() awful.util.mymainmenu:show() end)
))

-- Client Menu
local clientmenu = wibox.widget {
	markup = markup.font("FiraCode Nerd Font 14", markup("#A9B665", " 裡 ")),
	widget = wibox.widget.textbox
}
clientmenu:buttons(awful.util.table.join(
	awful.button({}, 1, function() awful.menu.client_list({ theme = { width = 250 } }) end)
))

-- Function to update the textbox text and color
local function update_bluetooth_textbox()
	local bluetooth_status = io.popen("hciconfig -a"):read("*all")
	if string.find(bluetooth_status, "UP") then
		bluetooth:set_markup(markup.font("FiraCode Nerd Font 10", markup(theme.fg_normal, " ")))
	else
		bluetooth:set_markup(markup.font("FiraCode Nerd Font 10", markup(theme.fg_normal, " ")))
	end
end

-- System tray
local tray = wibox.widget.systray();
tray:set_reverse(true)

-- Update the textbox on widget creation and every 10 seconds
update_bluetooth_textbox()
awful.widget.watch("hciconfig hci0", 5, update_bluetooth_textbox)


-- Separators
local spr        = wibox.widget.textbox(' ')
local spr_indent = wibox.widget.textbox('')
local arrl_dl    = separators.arrow_left(theme.bg_focus, theme.bg_normal)
local arrl_ld    = separators.arrow_left(theme.bg_normal, theme.bg_focus)

function theme.at_screen_connect(s)
	-- Quake application
	s.quake = lain.util.quake({ app = awful.util.terminal })

	-- If wallpaper is a function, call it with the screen
	local wallpaper = theme.wallpaper
	if type(wallpaper) == "function" then
		wallpaper = wallpaper(s)
	end
	gears.wallpaper.maximized(wallpaper, s, true)

	-- Tags
	awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(my_table.join(
		awful.button({}, 1, function() awful.layout.inc(1) end),
		awful.button({}, 2, function() awful.layout.set(awful.layout.layouts[1]) end),
		awful.button({}, 3, function() awful.layout.inc(-1) end),
		awful.button({}, 4, function() awful.layout.inc(1) end),
		awful.button({}, 5, function() awful.layout.inc(-1) end)))
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(22), bg = theme.bg_normal, fg = theme.fg_normal })

	-- Add widgets to the wibox
	s.mywibox:setup {
		layout = wibox.layout.align.horizontal,
		{
			-- Left widgets
			layout = wibox.layout.fixed.horizontal,
			spr_indent,
			awesomemenu,
			spr_indent,
			s.mytaglist,
			spr_indent,
			clientmenu,
			spr_indent,
			s.mypromptbox,
			spr,
		},
		s.mytasklist, -- Middle widget
		{
			-- Right widgets
			layout = wibox.layout.fixed.horizontal,
			spr,
			spr_indent,
			mpdinterface,
			spr,
			spr_indent,
			mpdprev,
			mpdtoggle,
			mpdstop,
			mpdnext,
			spr_indent,
			spr,
			tray,
			spr,
			spr,
			arrl_ld,
			wibox.container.background(net.widget, theme.bg_focus),
			arrl_dl,
			volicon,
			theme.volume.widget,
			arrl_ld,
			wibox.container.background(cpuicon, theme.bg_focus),
			wibox.container.background(cpu.widget, theme.bg_focus),
			arrl_dl,
			memicon,
			mem.widget,
			arrl_ld,
			wibox.container.background(fsicon, theme.bg_focus),
			wibox.container.background(theme.fs.widget, theme.bg_focus),
			arrl_dl,
			baticon,
			bat.widget,
			arrl_ld,
			wibox.container.background(spr, theme.bg_focus),
			wibox.container.background(spr, theme.bg_focus),
			wibox.container.background(
				brightness_widget {
					type = 'icon_and_text',
					program = 'light',
					step = 2,
					percentage = true,
					rmb_set_max = true
				}, theme.bg_focus
			),
			wibox.container.background(spr, theme.bg_focus),
			wibox.container.background(spr, theme.bg_focus),
			wibox.container.background(spr, theme.bg_focus),
			arrl_dl,
			spr,
			clock,
			spr,
			arrl_ld,
			wibox.container.background(s.mylayoutbox, theme.bg_focus),
			spr,
		},
	}
end

return theme

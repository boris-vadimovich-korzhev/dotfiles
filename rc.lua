--   ██████   ███     ██  █████   ██████  ██████  ██████████   █████ 
--  ▒▒▒▒▒▒██ ▒▒██  █ ▒██ ██▒▒▒██ ██▒▒▒▒  ██▒▒▒▒██▒▒██▒▒██▒▒██ ██▒▒▒██
--   ███████  ▒██ ███▒██▒███████▒▒█████ ▒██   ▒██ ▒██ ▒██ ▒██▒███████
--  ██▒▒▒▒██  ▒████▒████▒██▒▒▒▒  ▒▒▒▒▒██▒██   ▒██ ▒██ ▒██ ▒██▒██▒▒▒▒ 
-- ▒▒████████ ███▒ ▒▒▒██▒▒██████ ██████ ▒▒██████  ███ ▒██ ▒██▒▒██████
--  ▒▒▒▒▒▒▒▒ ▒▒▒    ▒▒▒  ▒▒▒▒▒▒ ▒▒▒▒▒▒   ▒▒▒▒▒▒  ▒▒▒  ▒▒  ▒▒  ▒▒▒▒▒▒ 
--      
--
--
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
--Add ons
local lain = require("lain")
local common = require("awful.widget.common")
vicious = require("vicious")
local minitray = require("minitray")
require("bashets")
awful.mouse = require("patches.mouse")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
naughty.notify({ preset = naughty.config.presets.critical,
title = "Fix this shit",
text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
local in_error = false
awesome.connect_signal("debug::error", function (err)
-- Make sure we don't go into an endless error loop
if in_error then return end
in_error = true

naughty.notify({ preset = naughty.config.presets.critical,
title = "Fix this shit",
text = err })
in_error = false
end)
end

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/themes/default/theme.lua")

-- This is used later as the default terminal and editor to run.

terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
lain.layout.uselessfair,
awful.layout.suit.floating,
lain.layout.centerwork,
lain.layout.termfair,
--lain.layout.cascade,
--lain.layout.cascadetile,
--lain.layout.centerfair,
--lain.layout.centerhwork,
lain.layout.uselesspiral,
--awful.layout.suit.spiral,
--awful.layout.suit.spiral.dwindle,
--awful.layout.suit.max

}

-- {{{ Wallpaper
if beautiful.wallpaper then
for s = 1, screen.count() do
gears.wallpaper.maximized(beautiful.wallpaper, s, true)
end
end

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
-- Each screen has its own tag table.
tags[s] = awful.tag({ "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "" }, s, layouts[1])
--tags[s] = awful.tag({ "  ", "  ", "  ", "  ", "  ", "" }, s, layouts[1])
end

-- " ", " ",
--{{{ Tag Wallpapers
--for s = 1, screen.count() do
--for t = 1, 6 do
--tags[s][t]:connect_signal("property::selected", function (tag)
--if not tag.selected then return end
--theme.wallpaper = "/home/svarog/.config/awesome/wallpaper/" .. t .. ".jpg"
--gears.wallpaper.maximized(beautiful.wallpaper, s, true)
--end)
--end
--end
-- }}}

--for s = 1, screen.count() do
--for t = 1, 6 do
--tags[s][t]:connect_signal("property::selected", function (tag)
--gears.wallpaper.maximized("/home/svarog/.config/awesome/wallpaper" .. tagname(t) .. --"_wallpaper.jpg",s,true)
--end)
--end
--end

-- {{{ Tag Wallpapers
--for s = 1, screen.count() do
--for t = 1, 6 do
--tags[s][t]:add_signal("property::selected", function (tag)
--if not tag.selected then return end
--wallpaper_cmd = "awsetbg /home/svarog/.config/awesome/wallpaper" .. t .. ".png"
--awful.util.spawn(wallpaper_cmd)
--end)
--end
--end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
{ "Manual", terminal .. " -e man awesome" },
{ "Edit Config", editor_cmd .. " " .. awesome.conffile },
{ "Restart", awesome.restart },
{ "Quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { 
--{ "awesome", myawesomemenu, beautiful.awesome_icon },
--{ "open terminal", terminal },
{ "Awesome", myawesomemenu },
}
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
menu = mymainmenu })

-- Create a laucher widget
--box = awful.widget.launcher({ name = "box",
--image = "/home/pix/dot.png",
--command = "compiz-boxmenu"})

menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- {{{ Wibox
--mpdvic = wibox.widget.textbox()
--vicious.register(mpdvic, vicious.widgets.mpd,
--function (widget, args)
--if   args["{state}"] == "Stop" then return ""
--else return ('<span color="#FF0000"> N</span><span color="#007AFF">o</span><span color="#FFFB00">w</span><span color="#BE00FF"> P</span><span color="#00FFD7">l</span><span color="#FF0068">a</span><span color="#00FF23">y</span><span color="#0004FF">i</span><span color="#FF5900">n</span><span color="#008CFF">g</span><span color="#ffffff"> ♬</span> ')..
--args["{Artist}"]..' - '.. args["{Title}"]
--end
--end)

mpdvic = wibox.widget.textbox()
vicious.register(mpdvic, vicious.widgets.mpd,
function (widget, args)
if   args["{state}"] == "Stop" then return ""
else return args["{Artist}"]..' - '.. args["{Title}"]
end
end)



--cpuicon = wibox.widget.imagebox()
--cpuicon:set_image("/home/pix/icon/cpu-icon.png")

--cpu = wibox.widget.textbox()
--vicious.register(cpu, vicious.widgets.cpu, "<span color='#FF0000'>                                                                                                       CPU </span><span color='#FFFFFF'>$1%</span>       ", 10)

--loadavg = wibox.widget.textbox()
--vicious.register(loadavg, vicious.widgets.uptime, "<span color='#FFFFFF'>      $4 $5 $6</span>   ", 5)

--temp = wibox.widget.textbox()
--vicious.register(temp, vicious.widgets.thermal, "<span color='#FFFFFF'>$1 ᵒC</span>  ", 20, "thermal_zone0")

--cpuinf = wibox.widget.textbox()
--vicious.register(cpuinf, vicious.widgets.cpuinf, "<span color='#FFFFFF'>${cpu0 ghz} Ghz</span>  ")

--memicon = wibox.widget.imagebox()
--memicon:set_image("/home/pix/icon/Memory.png")

--memwidget = wibox.widget.textbox()
--vicious.register(memwidget, vicious.widgets.mem, "<span color='#FF0000'>Mem Use </span><span color='#FFFFFF'>$1% $2 Mb</span>   ", 10)

--temp = wibox.widget.textbox()
--function execute_command(command)
--local fh = io.popen(command)
--local str = ""
--for i in fh:lines() do
--str = str .. i
--end
--io.close(fh)
--return str
--end
--temp.text = " " .. execute_command("/home/script/temp.sh") .. " "

--net = wibox.widget.textbox()
--vicious.register(net, vicious.widgets.net, "<span color='#FF0000'>Down </span><span color='#FFFFFF'> ${enp3s0 down_mb}</span>  <span color='#FF0000'>Up </span> <span color='#FFFFFF'>${enp3s0 up_mb}</span>   ", 1)

weather = wibox.widget.textbox()
vicious.register(weather, vicious.widgets.weather, '${tempc}˚C ${sky} ${humid}% ${windkmh} Kph ', 6000, "KJFK")

--diskicon = wibox.widget.imagebox()
--diskicon:set_image("/home/pix/icon/disk.png")

--disk = wibox.widget.textbox()
--vicious.register(disk, vicious.widgets.fs, '<span color="#ff0000">Disk </span><span color="#ffffff">${/ used_p}% </span><span color="#ff0000">Home </span><span color="#ffffff">${/home used_p}% </span>  ', 60)

--pacicon = wibox.widget.imagebox()
--pacicon:set_image("/home/pix/icon/pacman.png")

--pacwidget = wibox.widget.textbox()
--vicious.register(pacwidget, vicious.widgets.pkg, 'Updates <span color="#ffffff">$1</span>', 1800, "Arch")

--mytextclock = awful.widget.textclock('<span color="#ff0399"> %a </span><span color="#00ff7b">%b </span><span color="#FF2000">%d </span><span color="#0043ff">%Y </span> <span color="#E9FF00"> %H</span><span color="#ffffff">:</span><span color="#0089FF">%M</span><span color="#ffffff">:</span><span color="#FF0000">%S </span>', 1)

mytextclock = awful.widget.textclock(' %a %b %d %Y  %H %M %S', 1)

--lain.widgets.calendar:attach(mytextclock)

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
awful.button({ }, 1, awful.tag.viewonly),
awful.button({ modkey }, 1, awful.client.movetotag),
awful.button({ }, 3, awful.tag.viewtoggle),
awful.button({ modkey }, 3, awful.client.toggletag),
awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
awful.button({ }, 1, function (c)
if c == client.focus then
c.minimized = true
else
-- Without this, the following
-- :isvisible() makes no sense
c.minimized = false
if not c:isvisible() then
awful.tag.viewonly(c:tags()[1])
end
-- This will also un-minimize
-- the client, if needed
client.focus = c
c:raise()
end
end),
awful.button({ }, 3, function ()
if instance then
instance:hide()
instance = nil
else
instance = awful.menu.clients({
theme = { width = 250 }
})
end
end),
awful.button({ }, 4, function ()
awful.client.focus.byidx(1)
if client.focus then client.focus:raise() end
end),
awful.button({ }, 5, function ()
awful.client.focus.byidx(-1)
if client.focus then client.focus:raise() end
end))

for s = 1, screen.count() do
-- Create a promptbox for each screen
mypromptbox[s] = awful.widget.prompt()
-- Create an imagebox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
mylayoutbox[s] = awful.widget.layoutbox(s)
mylayoutbox[s]:buttons(awful.util.table.join(
awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
-- Create a taglist widget
mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

-- Create a tasklist widget
mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

-- Create the wibox
mywibox[s] = awful.wibox({ position = "top", ontop = true, screen = 2, height = "18" })

-- Widgets that are aligned to the left
local left_layout = wibox.layout.fixed.horizontal()
--left_layout:add(mylayoutbox[s])
--left_layout:add(box)
--left_layout:add(mylauncher)
left_layout:add(mytaglist[s])
--left_layout:add(mypromptbox[s])

-- Widgets that are aligned to the right
local right_layout = wibox.layout.fixed.horizontal()
--if s  == 1 then right_layout:add(wibox.widget.systray()) end
--right_layout:awful.util.spawn_with_shell("mpc current")
--right_layout:add(vol)
right_layout:add(mpdvic)

-- Now bring it all together (with the tasklist in the middle)
local layout = wibox.layout.align.horizontal()
layout:set_left(left_layout)
--layout:set_middle(mytasklist[s])
layout:set_right(right_layout)

mywibox[s]:set_widget(layout)

-- Bottom wibox
wibox[s] = awful.wibox({ position = "bottom", ontop = true, screen = 2, height = "18" })

local left2 = wibox.layout.fixed.horizontal()
--left2:add(cpuicon)
--left2:add(cpu)
--left2:add(cpuinf)
--left2:add(temp)
--left2:add(loadavg)
--left2:add(memicon)
--left2:add(memwidget)
--left2:add(diskicon)
--left2:add(disk)
--left2:add(net)
--left2:add(pacicon)
--left2:add(pacwidget)

local right2 = wibox.layout.fixed.horizontal()
right2:add(weather)
right2:add(mytextclock)

local layout2 = wibox.layout.align.horizontal()
layout2:set_left(left2)
layout2:set_right(right2)

wibox[s]:set_widget(layout2)

end

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
awful.button({ }, 3, function () mymainmenu:toggle() end),
awful.button({ }, 4, awful.tag.viewnext),
awful.button({ }, 5, awful.tag.viewprev)
))

-- {{{ Key bindings
globalkeys = awful.util.table.join(

-- custom
awful.key({ modkey, "Control" }, "d", function () awful.util.spawn_with_shell("rofi -hide-scrollbar -show run -regex -i -location 1 -lines 61 -width 500 -font 'Fantasque Sans Mono 10' -opacity '80' -color-enabled -color-normal '#000000,#95a7cc,#282828,#4b548e,#3f9fe2' -color-window '#000000,#00ffb4,#ffffff' -color-active '#3f9fe2,#4b548e,#000000,#4b548e' -color-urgent '#000000,#00ffb4,#3f9fe2' -bw 0 -line-margin 1 -separator-style 'none' -no-levenshtein-sort '$@'") end),
awful.key({ modkey,           }, "Escape", function () awful.util.spawn_with_shell("clerk") end),
awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
awful.key({ modkey, "Shift"   }, "Escape", awful.tag.history.restore),

awful.key({ modkey, "Shift"    }, "Right",	function () awful.tag.incmwfact( 0.01)	end),
awful.key({ modkey, "Shift"    }, "Left",	function () awful.tag.incmwfact(-0.01)	end),
awful.key({ modkey, "Shift"    }, "Down",	function () awful.client.incwfact( 0.01)end),
awful.key({ modkey, "Shift"    }, "Up",		function () awful.client.incwfact(-0.01)end),

awful.key({ modkey,           }, "j",
function ()
awful.client.focus.byidx( 1)
if client.focus then client.focus:raise() end
end),
awful.key({ modkey,           }, "k",
function ()
awful.client.focus.byidx(-1)
if client.focus then client.focus:raise() end
end),
awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

-- Layout manipulation
awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
--awful.key({ modkey,           }, "Tab",
--function ()
--awful.client.focus.history.previous()
--if client.focus then
--client.focus:raise()
--end
--end),

awful.key({ modkey,           }, "Tab",
function ()
for c in awful.client.iterate(function (x) return true end) do
client.focus = c
client.focus:raise()
end
end),

-- Standard program
awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
awful.key({ modkey, "Control" }, "r", awesome.restart),
awful.key({ modkey, "Shift"   }, "q", awesome.quit),

awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

awful.key({ modkey, "Control" }, "n", awful.client.restore),

-- Prompt
--awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

--awful.key({ modkey }, "x",
--function ()
--awful.prompt.run({ prompt = "Run Lua code: " },
--mypromptbox[mouse.screen].widget,
--awful.util.eval, nil,
--awful.util.getdir("cache") .. "/history_eval")
--end),
-- Menubar
awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
awful.key({ modkey, "Shift"   }, "z", function() minitray.toggle() end ),
awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
awful.key({ modkey,           }, "n",
function (c)
-- The client currently has the input focus, so it cannot be
-- minimized, since minimized clients can't have the focus.
c.minimized = true
end),
awful.key({ modkey,           }, "m",
function (c)
c.maximized_horizontal = not c.maximized_horizontal
c.maximized_vertical   = not c.maximized_vertical
end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
globalkeys = awful.util.table.join(globalkeys,
-- View tag only.
awful.key({ modkey }, "#" .. i + 9,
function ()
local screen = mouse.screen
local tag = awful.tag.gettags(screen)[i]
if tag then
awful.tag.viewonly(tag)
end
end),
-- Toggle tag.
awful.key({ modkey, "Control" }, "#" .. i + 9,
function ()
local screen = mouse.screen
local tag = awful.tag.gettags(screen)[i]
if tag then
awful.tag.viewtoggle(tag)
end
end),
-- Move client to tag.
awful.key({ modkey, "Shift" }, "#" .. i + 9,
function ()
if client.focus then
local tag = awful.tag.gettags(client.focus.screen)[i]
if tag then
awful.client.movetotag(tag)
end
end
end),
-- Toggle tag.
awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
function ()
if client.focus then
local tag = awful.tag.gettags(client.focus.screen)[i]
if tag then
awful.client.toggletag(tag)
end
end
end))
end

clientbuttons = awful.util.table.join(
awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
awful.button({ modkey }, 1, awful.mouse.client.move),
awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
-- All clients will match this rule.
{ rule = { },
properties = { border_width = beautiful.border_width,
border_color = beautiful.border_normal,
focus = awful.client.focus.filter,
raise = true,
keys = clientkeys,
buttons = clientbuttons } },
{ rule = { class = "MPlayer" },
properties = { floating = false } },
{ rule = { class = "pinentry" },
properties = { floating = true } },
{ rule = { class = "gimp" },
properties = { floating = false },
}
-- Set Firefox to always map on tags number 2 of screen 1.
-- { rule = { class = "Firefox" },
--   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
-- Enable sloppy focus
c:connect_signal("mouse::enter", function(c)
if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
and awful.client.focus.filter(c) then
client.focus = c
end
end)

if not startup then
-- Set the windows at the slave,
-- i.e. put it at the end of others instead of setting it master.
-- awful.client.setslave(c)

-- Put windows in a smart way, only if they does not set an initial position.
if not c.size_hints.user_position and not c.size_hints.program_position then
awful.placement.no_overlap(c)
awful.placement.no_offscreen(c)
end
end

local titlebars_enabled = false
if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
-- buttons for the titlebar
local buttons = awful.util.table.join(
awful.button({ }, 1, function()
client.focus = c
c:raise()
awful.mouse.client.move(c)
end),
awful.button({ }, 3, function()
client.focus = c
c:raise()
awful.mouse.client.resize(c)
end)
)

-- Widgets that are aligned to the left
local left_layout = wibox.layout.fixed.horizontal()
left_layout:add(awful.titlebar.widget.iconwidget(c))
left_layout:buttons(buttons)

-- Widgets that are aligned to the right
local right_layout = wibox.layout.fixed.horizontal()
right_layout:add(awful.titlebar.widget.floatingbutton(c))
right_layout:add(awful.titlebar.widget.maximizedbutton(c))
right_layout:add(awful.titlebar.widget.stickybutton(c))
right_layout:add(awful.titlebar.widget.ontopbutton(c))
right_layout:add(awful.titlebar.widget.closebutton(c))

-- The title goes in the middle
local middle_layout = wibox.layout.flex.horizontal()
local title = awful.titlebar.widget.titlewidget(c)
title:set_align("center")
middle_layout:add(title)
middle_layout:buttons(buttons)

-- Now bring it all together
local layout = wibox.layout.align.horizontal()
layout:set_left(left_layout)
layout:set_right(right_layout)
layout:set_middle(middle_layout)

awful.titlebar(c):set_widget(layout)
end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}}

local mod = "SUPER"

-- Layout helpers ------------------------------------------------------------

local function is_scrolling()
    local workspace = hl.get_active_special_workspace()
        or hl.get_active_workspace()

    return workspace and workspace.tiled_layout == "scrolling"
end

-- Runs a scrolling-layout message only on scrolling workspaces,
-- so these binds do nothing (instead of erroring) on dwindle workspaces.
local function scrolling_msg(msg)
    return function()
        if is_scrolling() then
            hl.dispatch(hl.dsp.layout(msg))
        end
    end
end

-- direction: "l" or "r"
local function focus_horizontal(direction)
    if is_scrolling() then
        hl.dispatch(hl.dsp.layout("focus " .. direction))
    else
        hl.dispatch(hl.dsp.focus({ direction = direction }))
    end
end

-- direction: "l" or "r"
-- scrolling: swap the column with its neighbour (niri: move-column-left/right)
-- dwindle:   move the window in that direction
local function move_column(direction)
    if is_scrolling() then
        hl.dispatch(hl.dsp.layout("swapcol " .. direction))
    else
        hl.dispatch(hl.dsp.window.move({ direction = direction }))
    end
end

-- Applications ----------------------------------------------------------------
hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd("foot"))
hl.bind(mod .. " + T", hl.dsp.exec_cmd("foot"))
hl.bind(mod .. " + SHIFT + RETURN", hl.dsp.exec_cmd("foot --app-id=floating-term"))
hl.bind(mod .. " + SHIFT + T", hl.dsp.exec_cmd("foot --app-id=floating-term"))
hl.bind(mod .. " + B", hl.dsp.exec_cmd("firefox"))
hl.bind(mod .. " + E", hl.dsp.exec_cmd("nautilus"))
hl.bind(mod .. " + M", hl.dsp.exec_cmd("spotify"))
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("foot --app-id=floating-term -e btop"))
hl.bind(mod .. " + SHIFT + B", hl.dsp.exec_cmd("foot --app-id=floating-term -e btop"))

-- Window management -------------------------------------------------------------
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + W", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + D", hl.dsp.window.fullscreen({ mode = "maximized" }))

-- Focus --------------------------------------------------------------------------
hl.bind(mod .. " + H", function() focus_horizontal("l") end)
hl.bind(mod .. " + L", function() focus_horizontal("r") end)
hl.bind(mod .. " + LEFT", function() focus_horizontal("l") end)
hl.bind(mod .. " + RIGHT", function() focus_horizontal("r") end)
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + DOWN", hl.dsp.focus({ direction = "d" }))
hl.bind(mod .. " + UP", hl.dsp.focus({ direction = "u" }))

-- Move windows / columns ----------------------------------------------------------
hl.bind(mod .. " + SHIFT + H", function() move_column("l") end)
hl.bind(mod .. " + SHIFT + L", function() move_column("r") end)
hl.bind(mod .. " + SHIFT + LEFT", function() move_column("l") end)
hl.bind(mod .. " + SHIFT + RIGHT", function() move_column("r") end)
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + SHIFT + DOWN", hl.dsp.window.move({ direction = "d" }))
hl.bind(mod .. " + SHIFT + UP", hl.dsp.window.move({ direction = "u" }))

-- Workspaces 1-9 ---------------------------------------------------------------------
for i = 1, 9 do
    hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Relative workspace navigation, including empty workspaces.
hl.bind(mod .. " + I", hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mod .. " + U", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mod .. " + Page_Up", hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mod .. " + Page_Down", hl.dsp.focus({ workspace = "r+1" }))

-- Move the active window to the previous / next workspace (niri: Mod+Ctrl+Up/Down/I/U).
hl.bind(mod .. " + CTRL + UP", hl.dsp.window.move({ workspace = "r-1" }))
hl.bind(mod .. " + CTRL + DOWN", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mod .. " + CTRL + I", hl.dsp.window.move({ workspace = "r-1" }))
hl.bind(mod .. " + CTRL + U", hl.dsp.window.move({ workspace = "r+1" }))

-- Column sizing and arrangement (scrolling layout only) -------------------------------
hl.bind(mod .. " + bracketleft", scrolling_msg("consume_or_expel prev"))
hl.bind(mod .. " + bracketright", scrolling_msg("consume_or_expel next"))
hl.bind(mod .. " + C", scrolling_msg("center"))
hl.bind(mod .. " + CTRL + F", scrolling_msg("fit expand"))
hl.bind(mod .. " + equal", scrolling_msg("colresize +0.1"))
hl.bind(mod .. " + minus", scrolling_msg("colresize -0.1"))
hl.bind(mod .. " + R", scrolling_msg("colresize +conf"))
-- Note: promote moves a window into its own column; it is NOT niri's tabbed mode.
hl.bind(mod .. " + period", scrolling_msg("promote"))

-- Noctalia controls ---------------------------------------------------------------------
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("noctalia msg brightness-up"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("noctalia msg brightness-down"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("noctalia msg volume-up"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("noctalia msg volume-down"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("noctalia msg volume-mute"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("noctalia msg mic-mute"))
hl.bind(mod .. " + O", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center"))
hl.bind(mod .. " + SHIFT + O", hl.dsp.exec_cmd("noctalia msg panel-toggle session"))
hl.bind(mod .. " + ALT + L", hl.dsp.exec_cmd("noctalia msg session lock"))
hl.bind(mod .. " + comma", hl.dsp.exec_cmd("noctalia msg settings-toggle"))
hl.bind(mod .. " + N", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center notifications"))
hl.bind(mod .. " + V", hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))
hl.bind(mod .. " + Y", hl.dsp.exec_cmd("noctalia msg panel-toggle wallpaper"))
hl.bind(mod .. " + SHIFT + Y", hl.dsp.exec_cmd("noctalia msg panel-toggle tadomika_ari/w-engine:w-engine-panel"))
hl.bind(mod .. " + A", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("noctalia msg media toggle"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- Hyprspace workspace overview
hl.bind("SUPER + TAB", function()
    hl.plugin.overview.toggle("all")
end)

-- Screenshots (the directory is created in autostart.lua) -------------------------------
local screenshot_dir = "$HOME/Pictures/Screenshots"
local function screenshot(mode)
    return hl.dsp.exec_cmd("hyprshot -m " .. mode .. " -o " .. screenshot_dir)
end

hl.bind("Print", screenshot("output"))
hl.bind("ALT + Print", screenshot("window"))
hl.bind("CTRL + Print", screenshot("region"))
hl.bind("XF86Launch1", screenshot("output"))

-- Turn monitors off; keyboard/mouse activity wakes them again.
-- A short timer is recommended by the wiki so the key release does not wake it instantly.
hl.bind(mod .. " + SHIFT + P", function()
    hl.timer(function()
        hl.dispatch(hl.dsp.dpms({ action = "disable" }))
    end, { timeout = 500, type = "oneshot" })
end)

-- Miscellaneous
hl.bind(mod .. " + SHIFT + E", hl.dsp.exit())

-- Move and resize windows from anywhere with Super + mouse.
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Toggles a "performance mode": disables animations, blur, shadows, wobble,
-- rounding, window transparency and the dynamic cursor plugin. Pressing the
-- bind again reloads the config, which restores every value (including
-- Noctalia colors).
local function toggle_gamemode()
    local active = (hl.get_config("animations.enabled") == false)

    if active then
        hl.exec_cmd("hyprctl reload")
        return
    end

    hl.config({
        animations = {
            enabled = false,
        },
        decoration = {
            rounding = 0,
            inactive_opacity = 1.0,
            wobble = { enabled = false },
            shadow = { enabled = false },
            blur = { enabled = false },
        },
    })

    -- The plugin may not be loaded (e.g. version mismatch after an update).
    if hl.plugin.dynamic_cursors then
        hl.config({
            plugin = {
                dynamic_cursors = { enabled = false },
            },
        })
    end
end

hl.bind("SUPER + F1", toggle_gamemode)

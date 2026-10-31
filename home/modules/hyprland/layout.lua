-- SUPER + SHIFT + I: toggle the active workspace between
-- Niri-like scrolling columns and the classic dwindle split layout.
hl.bind("SUPER + SHIFT + I", function()
    local workspace = hl.get_active_special_workspace()
        or hl.get_active_workspace()

    if not workspace then
        return
    end

    local next_layout =
        workspace.tiled_layout == "scrolling"
        and "dwindle"
        or "scrolling"

    local selector
    if workspace.special then
        selector = tostring(workspace.name)
    else
        selector = tostring(workspace.id)
    end

    hl.workspace_rule({
        workspace = selector,
        layout = next_layout,
    })
end)

-- Noctalia generates ~/.config/hypr/noctalia.lua (outside the Nix store) and
-- returns { colors = {...}, apply_theme = function }.
-- It is loaded right after options.lua, so its colors override the fallbacks.
--
-- The module may not exist yet (first boot, before Noctalia has run), and it
-- is re-read on every reload, so drop the cached copy and use pcall.
package.loaded["noctalia"] = nil

local ok, theme = pcall(require, "noctalia")

-- Builds a looping gradient from the palette: primary -> secondary -> primary.
-- Repeating the first color at the end hides the seam while the angle rotates.
local function border_gradient(colors)
    return {
        colors = { colors.primary, colors.secondary, colors.primary },
        angle = 45,
    }
end

if ok and type(theme) == "table" and type(theme.apply_theme) == "function" then
    -- Apply Noctalia's own borders and groups first.
    pcall(theme.apply_theme)

    -- Replace the flat active border with the gradient (inactive stays flat).
    local colors = theme.colors
    if type(colors) == "table" and colors.primary and colors.secondary then
        hl.config({
            general = {
                col = {
                    active_border = border_gradient(colors),
                },
            },
        })
    end
end

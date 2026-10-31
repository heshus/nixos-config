-- Noctalia generates ~/.config/hypr/noctalia.lua (outside the Nix store) and
-- returns { colors = {...}, apply_theme = function }.
-- It is loaded right after options.lua, so its colors override the fallbacks.
--
-- The module may not exist yet (first boot, before Noctalia has run), and it
-- is re-read on every reload, so drop the cached copy and use pcall.
package.loaded["noctalia"] = nil

local ok, theme = pcall(require, "noctalia")

if ok and type(theme) == "table" and type(theme.apply_theme) == "function" then
    pcall(theme.apply_theme)
end

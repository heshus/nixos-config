hl.on("hyprland.start", function()
    hl.exec_cmd("mkdir -p $HOME/Pictures/Screenshots")
    -- Clipboard history watcher and Noctalia shell.
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("pgrep -x noctalia >/dev/null || noctalia")
end)

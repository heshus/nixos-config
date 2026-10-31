-- Tiled, full-width windows.
hl.window_rule({
    match = { class = "^(steam|pavucontrol|nm-connection-editor|firefox)$" },
    tile = true,
    scrolling_width = 1.0,
})

-- Small utility windows (size expressions: no spaces inside each one).
hl.window_rule({
    match = { class = "^(floating-term|org\\.kde\\.dolphin|org\\.gnome\\.Nautilus|xdg-desktop-portal)$" },
    float = true,
    center = true,
    size = { "(monitor_w*0.5)", "(monitor_h*0.6)" },
})

-- Firefox Picture-in-Picture: floating and visible on every workspace.
hl.window_rule({
    match = {
        class = "^firefox$",
        title = "^(Picture-in-Picture|Картинка в картинке)$",
    },
    float = true,
    center = true,
    pin = true,
})

-- Zoom.
hl.window_rule({
    match = { class = "^zoom$" },
    float = true,
    center = true,
})

-- Noctalia settings window.
hl.window_rule({
    match = { class = "^dev\\.noctalia\\.Noctalia$" },
    float = true,
    center = true,
    size = { 1080, 920 },
})

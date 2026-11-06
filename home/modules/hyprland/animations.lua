-- Easing curves (a Y value above 1.0 produces an overshoot)

-- Fast start, long soft landing. Used for fades and exits.
hl.curve("smooth", {
    type = "bezier",
    points = { { 0.22, 1.0 }, { 0.36, 1.0 } },
})

-- Strong overshoot. Used for window open.
hl.curve("spring", {
    type = "bezier",
    points = { { 0.34, 1.56 }, { 0.64, 1.0 } },
})

-- Gentle overshoot. Used for movement and workspace switches.
hl.curve("spring-soft", {
    type = "bezier",
    points = { { 0.22, 1.25 }, { 0.36, 1.0 } },
})

-- Constant speed. Required for the endless border rotation.
hl.curve("linear", {
    type = "bezier",
    points = { { 0.0, 0.0 }, { 1.0, 1.0 } },
})

-- Default for any leaf that is not configured explicitly
hl.animation({
    leaf = "global",
    enabled = true,
    speed = 5,
    bezier = "smooth",
})

-- Window open: pops in from a smaller size with a bounce
hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 5,
    bezier = "spring",
    style = "popin 70%",
})

-- Window close: shrinks away without bounce
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 4,
    bezier = "smooth",
    style = "popin 85%",
})

-- Window move and resize: slight overshoot
hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 4,
    bezier = "spring-soft",
})

-- Workspace switch: vertical slide with fade and overshoot
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 6,
    bezier = "spring-soft",
    style = "slidefadevert 18%",
})

-- Opacity changes (focus dimming, fades)
hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 4,
    bezier = "smooth",
})

-- Border color transitions on focus change
hl.animation({
    leaf = "border",
    enabled = true,
    speed = 8,
    bezier = "smooth",
})

-- Continuous rotation of the border gradient angle
hl.animation({
    leaf = "borderangle",
    enabled = true,
    speed = 40,
    bezier = "linear",
    style = "loop",
})

-- Layer surfaces (Noctalia bar, panels) animate on their own
hl.animation({
    leaf = "layers",
    enabled = false,
})


-- Motion system: MD × Liquid Glass

hl.curve("glass-smooth", {
    type = "bezier",
    points = {
        { 0.22, 1.0 },
        { 0.36, 1.0 },
    },
})

hl.curve("glass-move", {
    type = "bezier",
    points = {
        { 0.25, 0.46 },
        { 0.45, 0.94 },
    },
})

hl.curve("glass-workspace", {
    type = "bezier",
    points = {
        { 0.16, 1.0 },
        { 0.3, 1.0 },
    },
})

-- Global
hl.animation({
    leaf = "global",
    enabled = true,
    speed = 5,
    bezier = "glass-smooth",
})

-- Window appearance
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 5,
    bezier = "glass-smooth",
    style = "popin 92%",
})

-- Window movement and resizing
hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 3,
    bezier = "glass-move",
})

-- Workspace transitions
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 6,
    bezier = "glass-workspace",
    style = "slidefadevert 18%",
})

-- Opacity transitions
hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 4,
    bezier = "glass-smooth",
})

-- Layer surfaces
hl.animation({
    leaf = "layers",
    enabled = false,
})

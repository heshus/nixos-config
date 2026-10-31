
hl.config({
    general = {
        gaps_in = 6,
        gaps_out = 12,
        border_size = 2,
        layout = "dwindle",
        resize_on_border = true,
        extend_border_grab_area = 15,
        allow_tearing = false,

        col = {
            active_border = "rgb(8cd5b4)",
            inactive_border = "rgb(0f1512)",
        },
    },

    decoration = {
        rounding = 14,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 0.86,

        wobble = {
            enabled = true,
            mesh = 12,
            stiffness = 200,
            damping = 12,
            mass = 1,
            intensity = 0.2,
            value_epsilon = 0.25,
            velocity_epsilon = 2,
        },
        shadow = {
            enabled = true,
            range = 28,
            render_power = 3,
            offset = { 0, 7 },
            color = "rgba(00000066)",
        },

        blur = {
            enabled = true,
            size = 6,
            passes = 3,
            noise = 0.025,
            contrast = 0.92,
            brightness = 0.95,
            vibrancy = 0.35,
            vibrancy_darkness = 0.45,
            ignore_opacity = true,
            new_optimizations = true,
            xray = false,
            popups = true,
        },
    },

    scrolling = {
        column_width = 0.5,
        explicit_column_widths = "0.333, 0.5, 0.667, 1.0",
        direction = "right",
        follow_focus = true,
        focus_fit_method = 1,
        wrap_focus = true,
        wrap_swapcol = true,
    },

    dwindle = {
        preserve_split = true,
    },

    input = {
        kb_layout = "us,ru",
        kb_options = "grp:alt_shift_toggle,grp:win_space_toggle",
        numlock_by_default = true,
        accel_profile = "flat",
        sensitivity = 0,
        follow_mouse = 1,

        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
        },
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
    },
})

-- Noctalia backdrop
hl.layer_rule({
    name = "noctalia-backdrop",
    match = {
        namespace = "^noctalia-backdrop.*$",
    },
    blur = true,
    blur_popups = true,
    xray = false,
})

-- Noctalia UI: blur and animation handling
hl.layer_rule({
    name = "noctalia",
    match = {
        namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
    },
    no_anim = true,
    ignore_alpha = 0.5,
    blur = true,
    blur_popups = true,
})

-- Dynamic cursors
if hl.plugin.dynamic_cursors then
    hl.config({
        plugin = {
            dynamic_cursors = {
                enabled = true,
                mode = "tilt",
            },
        },
    })
end

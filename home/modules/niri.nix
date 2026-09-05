{ config, ... }:

{
  xdg.configFile = {
    "niri/animations.kdl".source = ./niri/animations.kdl;
    "niri/appearance.kdl".source = ./niri/appearance.kdl;
    "niri/binds.kdl".source = ./niri/binds.kdl;
    "niri/layout.kdl".source = ./niri/layout.kdl;
    "niri/windowrules.kdl".source = ./niri/windowrules.kdl;
    "niri/workspaces.kdl".source = ./niri/workspaces.kdl;
  };

  xdg.configFile."niri/config.kdl".text = ''
    output "HDMI-A-1" {
        mode "1920x1080@165.003"
    }

    /-config-notification {
        disable-failed
    }

    
    cursor {
      xcursor-theme "${config.my.cursor.name}"
      xcursor-size ${toString config.my.cursor.size}
    }
    gestures {
        hot-corners {
            off
        }
    }

    input {
        keyboard {
            xkb {
                layout "us,ru"
                options "grp:alt_shift_toggle,grp:win_space_toggle"
            }
            numlock
        }

        touchpad {
            natural-scroll
            dwt
            tap
        }

        mouse {
            accel-profile "flat"
            accel-speed 0.0
        }

        trackpoint {
        }

        focus-follows-mouse max-scroll-amount="0%"
    }

    environment {
        XDG_CURRENT_DESKTOP "niri"
        QT_QPA_PLATFORMTHEME "qt6ct"
        XCURSOR_THEME "${config.my.cursor.name}"
        XCURSOR_SIZE "${toString config.my.cursor.size}"
    }

    hotkey-overlay {
        skip-at-startup
    }

    prefer-no-csd

    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    spawn-at-startup "bash" "-c" "wl-paste --watch cliphist store &"
    spawn-at-startup "noctalia"

    debug {
        honor-xdg-activation-with-invalid-serial
    }

    include "layout.kdl"
    include "appearance.kdl"
    include "animations.kdl"
    include "workspaces.kdl"
    include "binds.kdl"
    include "windowrules.kdl"
    include "noctalia.kdl"
  '';
}

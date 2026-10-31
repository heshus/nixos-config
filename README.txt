HYPRLAND CONFIG DROP-IN
=======================

This archive contains the complete Home Manager Hyprland Lua setup based on
your existing Niri config.

Install from ~/nixos:
  unzip -o ~/Downloads/hyprland-config.zip -d .
  git add home/modules/hyprland.nix home/modules/hyprland/
  rebuild

The archive preserves Niri. Do not remove ./niri.nix or programs.niri.enable;
you can select Niri from your login manager if Hyprland is unhappy.

Included:
- HDMI-A-1 at 1920x1080@165Hz
- scrolling as the default layout, dwindle toggle on SUPER+SHIFT+SPACE
- persistent steam/music/chat workspaces and application routing
- Noctalia commands and layer blur rules
- fast, non-viscous animations, 12px rounding, shadows and blur
- migrated app, workspace, window, monitor and screenshot bindings
- Nixpkgs hypr-dynamic-cursors
- guarded config/bindings for ScrollOverview and macos-zoom

Important plugin note:
Only hypr-dynamic-cursors is installed declaratively by this Nix module.
ScrollOverview and macos-zoom are configured conditionally, but are not
loaded by this archive because they are not in the Nixpkgs plugin set you
currently use. Their settings/binds activate once those plugins are packaged
and loaded for the exact Hyprland 0.56.2 build.

Noctalia:
The existing NixOS programs.noctalia.enable setting is assumed to remain on.

The current default layout is scrolling. SUPER+SHIFT+SPACE switches the
current workspace to dwindle and back. SUPER+TAB / SUPER+S call ScrollOverview
when that plugin is present.

This is a complete initial migration, not a promise that every Niri-only
feature has a one-to-one Hyprland equivalent. In particular Niri's built-in
overview and its exact backdrop placement do not have a native equivalent;
the ScrollOverview plugin is the intended replacement.

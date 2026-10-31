{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;

  cursor = config.my.cursor;
  qtTheme = config.my.qt.theme;

  environmentLua = pkgs.writeText "environment.lua" ''
    -- Session/toolkit environment.
    -- UWSM manages the core XDG session variables.
    hl.env("QT_QPA_PLATFORMTHEME", "${qtTheme}")
    hl.env("XCURSOR_THEME", "${cursor.name}")
    hl.env("XCURSOR_SIZE", "${toString cursor.size}")
  '';
in {
  options.my.qt.theme = lib.mkOption {
    type = lib.types.str;
    default = "qt6ct";
    description = "Qt platform theme (QT_QPA_PLATFORMTHEME).";
  };

  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;

      # Используем системный Hyprland
      package = null;
      portalPackage = null;

      configType = "lua";

      plugins = [
        inputs.hypr-dynamic-cursors.packages.${system}.hypr-dynamic-cursors
        inputs.hyprspace.packages.${system}.Hyprspace
      ];

      extraLuaFiles = {
        "00-monitors" = ./hyprland/monitors.lua;
        "05-environment" = environmentLua;
        "10-options" = ./hyprland/options.lua;
        "12-theme" = ./hyprland/theme.lua;
        "20-animations" = ./hyprland/animations.lua;
        "40-windowrules" = ./hyprland/windowrules.lua;
        "50-layout" = ./hyprland/layout.lua;
        "55-hyprspace" = ./hyprland/hyprspace.lua;
        "60-binds" = ./hyprland/binds.lua;
        "80-autostart" = ./hyprland/autostart.lua;
      };
    };

    home.packages = with pkgs; [
      hyprshot
      wl-clipboard
      cliphist
    ];
  };
}

{ config, lib, pkgs, ... }:

{
  options.my.cursor = {
    name = lib.mkOption {
      type = lib.types.str;
      default = "phinger-cursors-light";
    };

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.phinger-cursors;
    };

    size = lib.mkOption {
      type = lib.types.int;
      default = 24;
    };
  };

  config = {
    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      x11.enable = true;

      name = config.my.cursor.name;
      package = config.my.cursor.package;
      size = config.my.cursor.size;
    };

    home.sessionVariables = {
      XCURSOR_THEME = config.my.cursor.name;
      XCURSOR_SIZE = toString config.my.cursor.size;
    };

    systemd.user.sessionVariables = {
      XCURSOR_THEME = config.my.cursor.name;
      XCURSOR_SIZE = toString config.my.cursor.size;
    };
  };
}

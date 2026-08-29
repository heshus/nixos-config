{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    user = "heshus";
    dataDir = "/home/heshus/";
    configDir = "/home/heshus/.config/syncthing";
    guiAddress = "127.0.0.1:8384";

    overrideDevices = false;
    overrideFolders = false;
  };
}

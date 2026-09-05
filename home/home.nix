{ config, pkgs, ... }:
{
  home.username = "heshus";
  home.homeDirectory = "/home/heshus";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
  
  imports = [
    ./modules
  ];
}

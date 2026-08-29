{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos-laptop";

  system.stateVersion = "26.05"; # Did you read the comment?
}

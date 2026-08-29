{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];
  fileSystems."/home/heshus/games" = {
  device = "/dev/disk/by-uuid/f99d4c34-e7f0-4bbf-934b-bc5d32f43b3c";
  fsType = "ext4";
  options = [ "defaults" "noatime" ];
};

fileSystems."/home/heshus/docs" = {
  device = "/dev/disk/by-uuid/cf43c901-4a2a-43e1-9eb8-bd468f280354";
  fsType = "ext4";
  options = [ "defaults" "noatime" ];
};
  networking.hostName = "nixos-desktop";

  system.stateVersion = "26.05";
}

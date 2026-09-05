{config, pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./nix.nix
    ./memory.nix
    ./storage.nix
    ./networking.nix
    ./desktop.nix
    ./audio.nix
    ./packages.nix
    ./fonts.nix
    ./gaming.nix
    ./printing.nix
    ./syncthing.nix
  ];
  programs.zsh.enable = true; 
  users.users.heshus = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "input"
      "networkmanager"
    ];
  };
}

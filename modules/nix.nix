{ ... }:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  programs.nh = {
    enable = true;
    flake = "/home/heshus/nixos";
    clean = {
      enable = true;
      extraArgs = "--keep 5 --keep-since 7d";
    };
  };

  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };
}
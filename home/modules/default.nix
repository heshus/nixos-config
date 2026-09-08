{pkgs, ...}: {
  imports = [
    ./packages.nix
    ./zsh.nix
    ./cursor.nix
    ./niri.nix
    ./gtk.nix
    ./fastfetch.nix
    ./media.nix
    ./vps-tunnel.nix
    ./foot.nix
    ./nvim/default.nix
  ];
}

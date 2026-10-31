{pkgs, ...}: {
  imports = [
    ./packages.nix
    ./zsh.nix
    ./cursor.nix
    ./hyprland.nix
    ./gtk.nix
    ./fastfetch.nix
    ./media.nix
    ./foot.nix
    ./nvim/default.nix
    ./firefox/default.nix
  ];
}

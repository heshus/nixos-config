{pkgs,inputs, ...}: {
  home.packages = with pkgs; [
    impression
    qbittorrent
    obsidian
    zathura
    ayugram-desktop
    btop
    nautilus
    vesktop
    cava
    spotify
    zed-editor
  ];
}

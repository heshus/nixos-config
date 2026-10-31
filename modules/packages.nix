{ pkgs,  ... }:
{
  environment.systemPackages = with pkgs; [
    zsh
    glib
    file
    gcc
    gnumake
    pkg-config
    xwayland-satellite
    vim
    wget
    git
    stow
    gnutar
    gzip
    zip
    unzip
    p7zip
    unrar
    file-roller
    kdePackages.qt6ct
    libreoffice-stable
    hunspellDicts.ru_RU
    hunspellDicts.en_US
    blueman
  ];
}

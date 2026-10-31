{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    file
    vim
    wget
    git
    zip
    unzip
    p7zip
    file-roller
    kdePackages.qt6ct
    libreoffice-stable
    hunspellDicts.ru_RU
    hunspellDicts.en_US
  ];
}

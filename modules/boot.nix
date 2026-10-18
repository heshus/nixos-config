{pkgs, ...}: {
  boot.loader = {
    efi.canTouchEfiVariables = true;

    # Отключаем systemd-boot
    systemd-boot.enable = false;

    # Включаем GRUB
    grub = {
      enable = true;
      efiSupport = true;
      devices = ["nodev"];
      fontSize = 16;
    };
    # Vimix theme
    grub2-theme = {
      enable = true;
      theme = "vimix";
      icon = "color";
      screen = "1080p";
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
}

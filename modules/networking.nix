{lib, ...}: {
  networking.networkmanager.enable = true;

  programs.amnezia-vpn.enable = true;

  time.timeZone = "Europe/Moscow";

  hardware.bluetooth.enable = true;

  hardware.bluetooth.powerOnBoot = true;

  networking.nameservers = ["8.8.8.8" "1.1.1.1"];

  programs.kdeconnect.enable = true;
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };
}

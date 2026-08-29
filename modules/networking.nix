{ ... }:
{
  networking.networkmanager.enable = true;
  programs.amnezia-vpn.enable = true;
  time.timeZone = "Europe/Moscow";
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}

{ ... }:
{
  boot.kernel.sysctl."vm.swappiness" = 100;
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 70;
    priority = 100;
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024;
      priority = 10;
    }
  ];

  # systemd.oomd = {
  #   enable = true;
  #   enableRootSlice = true;
  #   enableUserSlices = true;
  # };
}

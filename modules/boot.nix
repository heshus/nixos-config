{pkgs, ...}: {
  boot.loader = {
    timeout = 3;
    efi.canTouchEfiVariables = true;
    systemd-boot = {
          enable = true;
          consoleMode = "keep";
          editor = false;
           configurationLimit = 10;
        };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
}

{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin pkgs.gutenprint ];
  };

  hardware.printers = {
    ensurePrinters = [
      {
        name = "HP_M1212nf";
        location = "Office";
        deviceUri = "usb://HP/LaserJet%20Professional%20M1212nf%20MFP?serial=000000000QJ5146SPR1a";
        model = "drv:///hp/hpcups.drv/hp-laserjet_professional_m1212nf_mfp.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
    ensureDefaultPrinter = "HP_M1212nf";
  };

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplipWithPlugin ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  users.users.heshus.extraGroups = [ "lp" "scanner" ];

  environment.systemPackages = with pkgs; [
    simple-scan
    usbutils
  ];
}

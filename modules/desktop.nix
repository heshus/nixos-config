{
  pkgs,
  inputs,
  ...
}: {
  i18n.defaultLocale = "ru_RU.UTF-8";
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  services.displayManager.noctalia-greeter.enable = true;
  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };
}

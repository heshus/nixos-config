{ pkgs,... }:
{
  i18n.defaultLocale = "ru_RU.UTF-8";

  programs.niri.enable = true;
  programs.noctalia = {
  enable = true;

};


  environment.systemPackages = with pkgs; [
   ffmpeg-headless
   ffmpegthumbnailer
   gdk-pixbuf

  libheif
  libheif.out
  libavif
  libjxl
  webp-pixbuf-loader
];
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  environment.pathsToLink = [
  "share/thumbnailers"
];
}

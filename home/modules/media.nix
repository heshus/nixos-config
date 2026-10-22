{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    yt-dlp
    ffmpeg
    imagemagick
    imv
    playerctl
    ffmpegthumbnailer
  ];

  programs.mpv = {
    enable = true;

    config = {
      hwdec = "auto";
      ytdl-format = "bestvideo+bestaudio/best";
      ytdl-raw-options =
        "cookies-from-browser=firefox:${config.home.homeDirectory}/.config/mozilla/firefox/default";
      save-position-on-quit = true;
      keep-open = true;
    };
  };
}

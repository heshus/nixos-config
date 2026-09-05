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
        "cookies-from-browser=firefox:${config.home.homeDirectory}/.config/zen/v9k9clgw.Default (release)";
      save-position-on-quit = true;
      keep-open = true;
    };
  };
}


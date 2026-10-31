{pkgs, ...}: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        selection-target = "both";
        include = "~/.config/foot/themes/noctalia";
        shell = "zsh";
        login-shell = "yes";
        font = "JetBrainsMono Nerd Font:size=13";
        pad = "10x10 center";
        resize-delay-ms = 50;
      };

      colors-dark = {
        alpha = "0.86";
        blur = true;
      };

      cursor = {
        style = "beam";
        beam-thickness = 2;
        blink = "yes";
        blink-rate = 600;
      };

      mouse.hide-when-typing = "no";
      scrollback.lines = 10000;
      url.launch = "xdg-open \${url}";
    };
  };
}

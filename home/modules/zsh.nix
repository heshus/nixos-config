{ pkgs,config, ... }:

{
  programs.zsh = {
    enable = true;

    # История
    history = {
      size = 10000;
      save = 10000;
      path = "${config.home.homeDirectory}/.zsh_history";
      ignoreDups = true;
      share = true;
    };

    # setopt AUTO_CD
    autocd = true;

    # oh-my-zsh
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
    };

    # Плагины — home-manager сам подставит нужные пакеты, ручной source не нужен
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Алиасы
    shellAliases = {
      mz = "zellij attach -c main";
      clock = "tty-clock -c";
      mpv = "noglob mpv";
      cat = "bat -pp";
      ls = "eza --icons=auto";
      ll = "eza -lh --icons=auto --git";
      la = "eza -lah --icons=auto --git";
      lt = "eza --tree --level=2 --icons=auto";
      ltt = "eza --tree --icons=auto";
      cow = "fortune | cowsay | lolcat";
      df = "duf";
      rebuild = "nh os switch -- --impure";
      update  = "nh os switch --update -- --impure";
};

    # Функции и всё что не укладывается в готовые опции
    initContent = ''
      livefetch() {
          tput civis
          trap 'tput cnorm; exit' INT TERM
          trap 'clear' WINCH
          while true; do
              tput cup 0 0
              fastfetch
              sleep "''${1:-1}"
          done
      }

      function y() {
          local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
          yazi "$@" --cwd-file="$tmp"
          if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
              cd -- "$cwd"
          fi
          rm -f -- "$tmp"
      }
    '';
  };

  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    FZF_DEFAULT_COMMAND = "fd --hidden --follow";
  };

  home.sessionPath = [
    "$HOME/my_scripts"
    "$HOME/.local/bin"
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [
    bat
    eza
    fortune
    cowsay
    lolcat
    duf
    yazi
    zellij
    tty-clock
    fastfetch
    fd
    mpv
  ];
}

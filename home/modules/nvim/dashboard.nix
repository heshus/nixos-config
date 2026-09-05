{ ... }:

{
  programs.nixvim = {

    # Dashboard logo color
    extraConfigLua = ''
      vim.api.nvim_set_hl(0, "DashboardHeader", {
        link = "DiagnosticInfo",
      })
    '';

    plugins.dashboard = {
      enable = true;

      settings = {
        theme = "hyper";

        config = {
          header = [
            "▐ ▄ ▄▄▄ .       ▌ ▐·▪  • ▌ ▄ ·. "
            "•█▌▐█▀▄.▀·▪     ▪█·█▌██ ·██ ▐███▪"
            "▐█▐▐▌▐▀▀▪▄ ▄█▀▄ ▐█▐█•▐█·▐█ ▌▐▌▐█·"
            "██▐█▌▐█▄▄▌▐█▌.▐▌ ███ ▐█▌██ ██▌▐█▌"
            "▀▀ █▪ ▀▀▀  ▀█▄▀▪. ▀  ▀▀▀▀▀  █▪▀▀▀"
          ];

          shortcut = [
            {
              desc = " Find file";
              group = "DiagnosticHint";
              action = "Telescope find_files";
              key = "f";
            }

            {
              desc = " Recent";
              group = "DiagnosticInfo";
              action = "Telescope oldfiles";
              key = "r";
            }

            {
              desc = " Config";
              group = "DiagnosticWarn";
              action = "e ~/nixos/home/modules/nvim";
              key = "c";
            }
          ];

          footer = [ "" ];
        };
      };
    };
  };
}

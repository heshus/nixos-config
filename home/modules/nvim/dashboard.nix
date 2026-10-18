{...}: {
  programs.nixvim = {
    # Dashboard logo color
    extraConfigLua = ''
      vim.api.nvim_set_hl(0, "DashboardHeader", { link = "DiagnosticInfo" })
      vim.api.nvim_set_hl(0, "DashboardMruIcon", { link = "DiagnosticWarn" })
      vim.api.nvim_set_hl(0, "DashboardFiles", { link = "Comment" })
      vim.api.nvim_set_hl(0, "DashboardFooter", { link = "Comment" })
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
            ""
          ];

          shortcut = [
            {
              desc = " Find file";
              group = "DiagnosticHint";
              action = "Telescope find_files";
              key = "f";
            }
            {
              desc = " Live grep";
              group = "DiagnosticError";
              action = "Telescope live_grep";
              key = "g";
            }
            {
              desc = " Recent";
              group = "DiagnosticInfo";
              action = "Telescope oldfiles";
              key = "r";
            }
            {
              desc = " New file";
              group = "DiagnosticWarn";
              action = "enew";
              key = "n";
            }
            {
              desc = " Config";
              group = "Number";
              action = "e ~/nixos/home/modules/nvim";
              key = "c";
            }
            {
              desc = " Quit";
              group = "DiagnosticOk";
              action = "qa";
              key = "q";
            }
          ];

          mru = {
            label = " Recent Files";
            cwd_only = false;
          };

          project = {
            enable = true;
            label = " Projects";
            action = "Telescope find_files cwd=";
          };

          footer = [
            ""
            "  nvim loaded"
          ];
        };
      };
    };
  };
}

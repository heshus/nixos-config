{ ... }:

{
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        type = "small";
        padding = {
          top = 3;
          right = 6;
          left = 4;
        };
      };

      display = {
        separator = " •  ";
      };

      modules = [
        {
          type = "title";
          color = {
            user = "32";
            at = "37";
            host = "32";
          };
        }

        "break"

        {
          type = "os";
          key = "distro    ";
          keyColor = "36";
        }

        {
          type = "kernel";
          key = "kernel    ";
          keyColor = "36";
        }


        {
          type = "cpu";
          key = "cpu       ";
          keyColor = "36";
        }

        {
          type = "gpu";
          key = "gpu       ";
          keyColor = "36";
        }

        {
          type = "memory";
          key = "memory    ";
          keyColor = "36";
        }

        {
          type = "swap";
          key = "swap      ";
          keyColor = "36";
        }

        {
          type = "disk";
          key = "disk      ";
          keyColor = "36";
          folders = [ "/" ];
        }

        {
          type = "packages";
          key = "packages  ";
          keyColor = "36";
        }

        {
          type = "wm";
          format = "{} ({3})";
          key = "wm        ";
          keyColor = "36";
        }

        "break"

        {
          type = "colors";
          symbol = "diamond";
        }

        "break"
        "break"
      ];
    };
  };
}

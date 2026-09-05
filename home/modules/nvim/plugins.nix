{ ... }:

{
  programs.nixvim.plugins = {

    # ─────────────────────────────────────────────
    # Completion
    # ─────────────────────────────────────────────

    cmp = {
      enable = true;
      autoEnableSources = true;

      settings = {
        preselect = "none";

        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];

        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";

          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";

          "<CR>" = "cmp.mapping.confirm({ select = false })";

          "<Tab>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end, { "i", "s" })
          '';

          "<S-Tab>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end, { "i", "s" })
          '';
        };
      };
    };

    # ─────────────────────────────────────────────
    # Treesitter
    # ─────────────────────────────────────────────

    treesitter = {
      enable = true;

      settings = {
        ensure_installed = [
          "bash"
          "c"
          "cpp"
          "css"
          "html"
          "javascript"
          "json"
          "lua"
          "markdown"
          "markdown_inline"
          "nix"
          "python"
          "rust"
          "toml"
          "typescript"
          "vim"
          "vimdoc"
          "yaml"
        ];

        highlight.enable = true;
        indent.enable = true;
      };
    };

    # ─────────────────────────────────────────────
    # Search
    # ─────────────────────────────────────────────

    telescope = {
      enable = true;

      extensions.fzf-native.enable = true;
    };

    # ─────────────────────────────────────────────
    # File tree
    # ─────────────────────────────────────────────

    neo-tree = {
      enable = true;

      settings = {
        close_if_last_window = true;
        popup_border_style = "rounded";

        filesystem = {
          follow_current_file.enabled = true;

          filtered_items = {
            hide_dotfiles = false;
            hide_gitignored = false;
          };
        };

        window = {
          position = "left";
          width = 32;
        };
      };
    };

    # ─────────────────────────────────────────────
    # Git
    # ─────────────────────────────────────────────

    gitsigns = {
      enable = true;

      settings = {
        current_line_blame = false;
        numhl = true;
      };
    };

    diffview.enable = true;

    # ─────────────────────────────────────────────
    # Diagnostics
    # ─────────────────────────────────────────────

    trouble = {
      enable = true;

      settings = {
        auto_close = true;
        auto_preview = false;
      };
    };

    # ─────────────────────────────────────────────
    # UI
    # ─────────────────────────────────────────────

    lualine = {
      enable = true;

      settings = {
        options = {
          globalstatus = true;
          section_separators = "";
          component_separators = "";
        };
      };
    };

    bufferline = {
      enable = true;

      settings = {
        options = {
          diagnostics = "nvim_lsp";
          separator_style = "slant";
          always_show_bufferline = true;
        };
      };
    };

    web-devicons.enable = true;

    which-key.enable = true;

    indent-blankline = {
      enable = true;

      settings = {
        scope.enabled = true;

        indent.char = "│";
      };
    };

    # ─────────────────────────────────────────────
    # Navigation
    # ─────────────────────────────────────────────

    flash.enable = true;

    # ─────────────────────────────────────────────
    # Mini
    # ─────────────────────────────────────────────

    mini = {
      enable = true;

      modules = {
        ai = { };
        pairs = { };
        surround = { };

        comment = {
          mappings = {
            comment = "<leader>/";
            comment_line = "<leader>/";
            comment_visual = "<leader>/";
            textobject = "<leader>/";
          };
        };
      };
    };

    # ─────────────────────────────────────────────
    # TODO
    # ─────────────────────────────────────────────

    todo-comments.enable = true;

    # ─────────────────────────────────────────────
    # Search / replace
    # ─────────────────────────────────────────────

    spectre.enable = true;

    # ─────────────────────────────────────────────
    # Formatting
    # ─────────────────────────────────────────────

    conform-nvim = {
      enable = true;

      settings = {
        formatters_by_ft = {
          rust = [ "rustfmt" ];
          python = [ "ruff_format" ];
          nix = [ "alejandra" ];
          c = [ "clang_format" ];
          cpp = [ "clang_format" ];
          lua = [ "stylua" ];
        };

        format_on_save = {
          timeout_ms = 500;
          lsp_fallback = true;
        };
      };
    };
  };
}


{pkgs, ...}: {
  home.packages = with pkgs; [
    # Rust
    rust-analyzer
    rustfmt

    # Python
    pyright
    ruff

    # Nix
    nixd
    alejandra

    # C / C++
    clang-tools

    # Lua
    lua-language-server
    stylua

    # General tooling
    ripgrep
    fd
  ];

  programs.nixvim = {
    lsp = {
      servers = {
        # ───────────────────────────────────────────
        # Rust
        # ───────────────────────────────────────────

        rust_analyzer = {
          enable = true;

          config = {
            rust-analyzer = {
              cargo.allFeatures = true;

              check = {
                command = "clippy";
              };

              procMacro.enable = true;
            };
          };
        };

        # ───────────────────────────────────────────
        # Python
        # ───────────────────────────────────────────

        pyright.enable = true;
        ruff.enable = true;

        # ───────────────────────────────────────────
        # Nix
        # ───────────────────────────────────────────

        nixd.enable = true;

        # ───────────────────────────────────────────
        # C / C++
        # ───────────────────────────────────────────

        clangd.enable = true;

        # ───────────────────────────────────────────
        # Lua
        # ───────────────────────────────────────────

        lua_ls.enable = true;
      };
    };
  };
}

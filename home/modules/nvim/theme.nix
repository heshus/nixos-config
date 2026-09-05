{ pkgs, ... }:

{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      base16-nvim
    ];

    extraConfigLuaPre = ''
      package.path =
        package.path
        .. ";"
        .. vim.fn.expand("~/.config/nvim/lua/?.lua")
    '';

    extraConfigLua = ''
      local ok, matugen = pcall(require, "matugen")

      if ok then
        matugen.setup()
      end
    '';
  };

  # ───────────────────────────────────────────────────────────
  # Noctalia → Base16
  # ───────────────────────────────────────────────────────────

  home.file.".config/nvim/lua/matugen-template.lua".text = ''
    local M = {}

    function M.setup()
      require("base16-colorscheme").setup {
        base00 = "{{colors.surface.default.hex}}",
        base01 = "{{colors.surface_container.default.hex}}",
        base02 = "{{colors.surface_container_high.default.hex}}",
        base03 = "{{colors.outline.default.hex}}",
        base04 = "{{colors.on_surface_variant.default.hex}}",
        base05 = "{{colors.on_surface.default.hex}}",
        base06 = "{{colors.on_surface.default.hex}}",
        base07 = "{{colors.on_background.default.hex}}",

        base08 = "{{colors.error.default.hex}}",
        base09 = "{{colors.tertiary.default.hex}}",
        base0A = "{{colors.secondary.default.hex}}",
        base0B = "{{colors.primary.default.hex}}",
        base0C = "{{colors.tertiary_fixed_dim.default.hex}}",
        base0D = "{{colors.primary_fixed_dim.default.hex}}",
        base0E = "{{colors.secondary_fixed_dim.default.hex}}",
        base0F = "{{colors.error_container.default.hex}}",
      }
    end

    if _G.__matugen_signal then
      _G.__matugen_signal:stop()
      _G.__matugen_signal:close()
    end

    local signal = vim.uv.new_signal()
    _G.__matugen_signal = signal

    signal:start("sigusr1", vim.schedule_wrap(function()
      package.loaded["matugen"] = nil

      local ok, matugen = pcall(require, "matugen")

      if ok then
        matugen.setup()
      end
    end))

    return M
  '';

  home.file.".config/noctalia/user-templates.toml".text = ''
    [templates.nvim-base16]
    input_path = "~/.config/nvim/lua/matugen-template.lua"
    output_path = "~/.config/nvim/lua/matugen.lua"
    post_hook = "pkill -SIGUSR1 nvim"
  '';
}

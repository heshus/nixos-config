{ ... }:

{
  programs.nixvim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    opts = {
      # ─────────────────────────────────────────────
      # UI
      # ─────────────────────────────────────────────

      number = true;
      relativenumber = true;

      cursorline = true;
      signcolumn = "yes";

      termguicolors = true;

      scrolloff = 8;
      sidescrolloff = 8;

      showmode = false;

      # ─────────────────────────────────────────────
      # Indentation
      # ─────────────────────────────────────────────

      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      softtabstop = 2;

      smartindent = true;

      # ─────────────────────────────────────────────
      # Search
      # ─────────────────────────────────────────────

      ignorecase = true;
      smartcase = true;

      hlsearch = true;
      incsearch = true;

      # ─────────────────────────────────────────────
      # Splits
      # ─────────────────────────────────────────────

      splitbelow = true;
      splitright = true;

      # ─────────────────────────────────────────────
      # Completion
      # ─────────────────────────────────────────────

      completeopt = [
        "menu"
        "menuone"
        "noselect"
      ];

      # ─────────────────────────────────────────────
      # Files
      # ─────────────────────────────────────────────

      undofile = true;

      # ─────────────────────────────────────────────
      # Performance
      # ─────────────────────────────────────────────

      updatetime = 250;
      timeoutlen = 400;

      # ─────────────────────────────────────────────
      # Clipboard
      # ─────────────────────────────────────────────

      clipboard = "unnamedplus";

      # ─────────────────────────────────────────────
      # Folding
      # ─────────────────────────────────────────────

      foldmethod = "expr";
      foldexpr = "v:lua.vim.treesitter.foldexpr()";
      foldlevel = 99;
      foldenable = true;

      # ─────────────────────────────────────────────
      # UI polish
      # ─────────────────────────────────────────────

      pumblend = 10;
      winblend = 0;
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
  };
}


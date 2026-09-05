{ ... }:

{
  programs.nixvim = {
    keymaps = [

      # ╭──────────────────────────────────────────╮
      # │ General                                  │
      # ╰──────────────────────────────────────────╯

      {
        mode = "n";
        key = "<leader>w";
        action = "<cmd>w<CR>";
        options.desc = "Save";
      }

      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>q<CR>";
        options.desc = "Quit";
      }

      {
        mode = "n";
        key = "<leader>nh";
        action = "<cmd>nohlsearch<CR>";
        options.desc = "Clear search highlight";
      }

      # ╭──────────────────────────────────────────╮
      # │ Telescope                                │
      # ╰──────────────────────────────────────────╯

      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        options.desc = "Find files";
      }

      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
        options.desc = "Live grep";
      }

      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
        options.desc = "Buffers";
      }

      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>Telescope oldfiles<CR>";
        options.desc = "Recent files";
      }

      {
        mode = "n";
        key = "<leader>fs";
        action = "<cmd>Telescope lsp_document_symbols<CR>";
        options.desc = "Document symbols";
      }

      # ╭──────────────────────────────────────────╮
      # │ Explorer                                 │
      # ╰──────────────────────────────────────────╯

      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<CR>";
        options.desc = "Explorer";
      }

      # ╭──────────────────────────────────────────╮
      # │ LSP                                      │
      # ╰──────────────────────────────────────────╯

      {
        mode = "n";
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        options.desc = "Definition";
      }

      {
        mode = "n";
        key = "gD";
        action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
        options.desc = "Declaration";
      }

      {
        mode = "n";
        key = "gr";
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
        options.desc = "References";
      }

      {
        mode = "n";
        key = "gi";
        action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
        options.desc = "Implementation";
      }

      {
        mode = "n";
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
        options.desc = "Hover";
      }

      {
        mode = "n";
        key = "<leader>la";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        options.desc = "Code action";
      }

      {
        mode = "n";
        key = "<leader>lr";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        options.desc = "Rename";
      }

      {
        mode = "n";
        key = "<leader>lf";
        action = "<cmd>lua vim.lsp.buf.format()<CR>";
        options.desc = "Format";
      }

      # ╭──────────────────────────────────────────╮
      # │ Diagnostics                              │
      # ╰──────────────────────────────────────────╯

      {
        mode = "n";
        key = "[d";
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
        options.desc = "Previous diagnostic";
      }

      {
        mode = "n";
        key = "]d";
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
        options.desc = "Next diagnostic";
      }

      {
        mode = "n";
        key = "<leader>dd";
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
        options.desc = "Diagnostic details";
      }

      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<CR>";
        options.desc = "Diagnostics";
      }

      {
        mode = "n";
        key = "<leader>xX";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<CR>";
        options.desc = "Buffer diagnostics";
      }

      # ╭──────────────────────────────────────────╮
      # │ Git                                      │
      # ╰──────────────────────────────────────────╯

      {
        mode = "n";
        key = "<leader>gd";
        action = "<cmd>DiffviewOpen<CR>";
        options.desc = "Git diff";
      }

      {
        mode = "n";
        key = "<leader>gD";
        action = "<cmd>DiffviewClose<CR>";
        options.desc = "Close diff";
      }

      {
        mode = "n";
        key = "<leader>gb";
        action = "<cmd>Gitsigns toggle_current_line_blame<CR>";
        options.desc = "Toggle blame";
      }

      # ╭──────────────────────────────────────────╮
      # │ Search                                   │
      # ╰──────────────────────────────────────────╯

      {
        mode = "n";
        key = "<leader>sr";
        action = "<cmd>lua require('spectre').toggle()<CR>";
        options.desc = "Search & replace";
      }

      # ╭──────────────────────────────────────────╮
      # │ Flash                                    │
      # ╰──────────────────────────────────────────╯

      {
        mode = [ "n" "x" "o" ];
        key = "s";
        action = "<cmd>lua require('flash').jump()<CR>";
        options.desc = "Flash jump";
      }

      # ╭──────────────────────────────────────────╮
      # │ Buffers                                  │
      # ╰──────────────────────────────────────────╯

      {
        mode = "n";
        key = "<S-l>";
        action = "<cmd>BufferLineCycleNext<CR>";
        options.desc = "Next buffer";
      }

      {
        mode = "n";
        key = "<S-h>";
        action = "<cmd>BufferLineCyclePrev<CR>";
        options.desc = "Previous buffer";
      }

      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>bdelete<CR>";
        options.desc = "Delete buffer";
      }

      # ╭──────────────────────────────────────────╮
      # │ Windows                                  │
      # ╰──────────────────────────────────────────╯

      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options.desc = "Move left";
      }

      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options.desc = "Move down";
      }

      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options.desc = "Move up";
      }

      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options.desc = "Move right";
      }

      # ╭──────────────────────────────────────────╮
      # │ Terminal                                 │
      # ╰──────────────────────────────────────────╯

      {
        mode = "n";
        key = "<leader>tt";
        action = "<cmd>split | terminal<CR>";
        options.desc = "Terminal";
      }
    ];

    # ─────────────────────────────────────────────
    # Diagnostics
    # ─────────────────────────────────────────────

    extraConfigLua = ''
      vim.diagnostic.config({
        virtual_text = {
          spacing = 2,
          prefix = "●",
        },

        signs = true,
        underline = true,
        update_in_insert = false,

        severity_sort = true,

        float = {
          border = "rounded",
          source = "if_many",
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }

          vim.keymap.set(
            "n",
            "K",
            vim.lsp.buf.hover,
            opts
          )

          vim.keymap.set(
            "n",
            "gd",
            vim.lsp.buf.definition,
            opts
          )

          vim.keymap.set(
            "n",
            "gr",
            vim.lsp.buf.references,
            opts
          )

          vim.keymap.set(
            "n",
            "<leader>la",
            vim.lsp.buf.code_action,
            opts
          )

          vim.keymap.set(
            "n",
            "<leader>lr",
            vim.lsp.buf.rename,
            opts
          )
        end,
      })
    '';
  };
}


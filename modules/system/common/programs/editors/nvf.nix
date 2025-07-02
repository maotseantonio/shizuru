{
  inputs,
  pkgs,
  ...
}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        preventJunkFiles = true; # stop those weird ~ files from appearing
        undoFile.enable = true; # multi-session undo
        enableLuaLoader = true;
        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
          registers = "unnamedplus";
        };
        viAlias = true;
        vimAlias = true;
        luaConfigRC = {
          basic = ''
            -- Restore terminal cursor to vertical beam on exit
            vim.api.nvim_create_autocmd("ExitPre", {
              group = vim.api.nvim_create_augroup("Exit", { clear = true }),
              command = "set guicursor=a:ver1",
              desc = "Set cursor back to beam when leaving Neovim.",
            })

            -- Remove "disable mouse" entries from the context menu
            vim.api.nvim_create_autocmd("VimEnter", {
              callback = function()
                vim.cmd("aunmenu PopUp.How-to\\ disable\\ mouse")
                vim.cmd("aunmenu PopUp.-1-")
              end,
              desc = "Remove 'disable mouse' entries from context menu",
            })
          '';
        };

        lsp = {
          formatOnSave = true;
          trouble.enable = true;
          lspSignature.enable = true;
          lightbulb.enable = true;
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };

        lsp.enable = true;

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          nix.enable = true;
          nix.lsp.package = pkgs.nil;
          markdown.enable = true;

          bash.enable = true;
          clang.enable = true;
          css.enable = true;
          html.enable = true;
          ts.enable = true;
          lua.enable = true;
          python.enable = true;
        };

        notes = {
          todo-comments.enable = true;
        };

        visuals = {
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          fidget-nvim.enable = true;

          highlight-undo.enable = true;
          indent-blankline.enable = true;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "catppuccin";
          };
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = true;
        };

        autopairs.nvim-autopairs.enable = true;

        autocomplete.nvim-cmp.enable = true;
        snippets.luasnip.enable = true;

        filetree = {
          neo-tree = {
            enable = true;
          };
        };

        tabline = {
          nvimBufferline.enable = true;
        };

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false; # throws an annoying debug message
        };

        dashboard = {
          alpha.enable = true;
        };

        utility = {
          icon-picker.enable = true;
          diffview-nvim.enable = true;
          motion = {
            leap.enable = true;
          };
          yazi-nvim.enable = true;
        };
        
        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        ui = {
          noice.enable = true;
          colorizer.enable = true;
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          fastaction.enable = true;
        };

        assistant = {
          copilot = {
            enable = true;
            cmp.enable = true;
          };
        };

        comments = {
          comment-nvim.enable = true;
        };

        presence = {
          neocord.enable = true;
        };
      };
    };
  };
  # make indents normal lmfao
  hj = {
    files.".editorconfig".source = (pkgs.formats.ini {}).generate ".editorconfig" {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        indent_size = 2;
        indent_style = "space";
        insert_final_newline = true;
        max_line_width = 80;
        trim_trailing_whitespace = true;
      };
    };
  };
}

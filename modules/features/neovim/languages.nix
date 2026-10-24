{
  perSystem = {
    nvfModules = [
      {
        config.vim = {
          lsp = {
            enable = true;
            inlayHints.enable = true;

            mappings = {
              format = "<leader>F";
              goToDefinition = "gd";
              goToDeclaration = "<leader>gD";
              listReferences = "<leader>gr";
              listImplementations = "<leader>gI";
              openDiagnosticFloat = "<leader>f";
              nextDiagnostic = "<leader>]q";
              previousDiagnostic = "<leader>[q";
              hover = "K";
              renameSymbol = "<leader>rn";
              codeAction = "<leader>ca";
            };

            presets.tailwindcss-language-server.enable = true;
          };

          debugger.nvim-dap = {
            enable = true;
            ui.enable = true;
          };
          luaConfigRC.dap-go-custom = ''
            table.insert(require("dap").configurations.go, {
              type = "go",
              name = "Debug (Build Flags)",
              request = "launch",
              program = "''${file}",
              buildFlags = require("dap-go").get_build_flags,
              outputMode = "remote",
            })
          '';

          languages = {
            enableTreesitter = true;
            enableFormat = true;
            enableExtraDiagnostics = true;

            clang.enable = true;
            go = {
              enable = true;
              dap.enable = true;
            };
            html.enable = true;
            lua.enable = true;
            nix.enable = true;
            python.enable = true;
            svelte.enable = true;
            typescript.enable = true;
            typst = {
              enable = true;
              extensions = {
                typst-concealer.enable = true;
              };
            };
            vue.enable = true;
          };
        };

      }
    ];
  };
}

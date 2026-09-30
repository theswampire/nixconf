{
  perSystem = {
    nvfModules = [
      {
        config.vim.lsp = {
          enable = true;
          inlayHints.enable = true;

          mappings.format = "<leader>F";
          mappings.goToDefinition = "gd";
          mappings.goToDeclaration = "<leader>gD";
          mappings.listReferences = "<leader>gr";
          mappings.listImplementations = "<leader>gI";
          mappings.openDiagnosticFloat = "<leader>f";
          mappings.nextDiagnostic = "<leader>]q";
          mappings.previousDiagnostic = "<leader>[q";
          mappings.hover = "K";
          mappings.renameSymbol = "<leader>rn";
          mappings.codeAction = "<leader>ca";
        };

        config.vim.languages = {
          enableTreesitter = true;
          enableFormat = true;
          enableExtraDiagnostics = true;

          nix.enable = true;
          lua.enable = true;
          go.enable = true;
          typst = {
            enable = true;
            extensions = {
              typst-concealer.enable = true;
            };
          };
        };
      }
    ];
  };
}

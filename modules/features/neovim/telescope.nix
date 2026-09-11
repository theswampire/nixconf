{
  perSystem = { pkgs, ... }: {
    nvfModules = [
      {
        config.vim.telescope = {
          enable = true;

          extensions = [
            {
              name = "fzf";
              packages = [ pkgs.vimPlugins.telescope-fzf-native-nvim ];
              setup = {
                fzf = {
                  fuzzy = true;
                };
              };
            }
            {
              name = "ui-select";
              packages = [ pkgs.vimPlugins.telescope-ui-select-nvim ];
            }
          ];
          mappings.liveGrep = "<leader>sg";
          mappings.findFiles = "<leader>sf";
        };
      }
    ];
  };
}

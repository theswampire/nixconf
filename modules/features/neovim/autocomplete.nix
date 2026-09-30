{
  perSystem.nvfModules = [
    {

      config.vim = {
        autocomplete.blink-cmp = {
          enable = true;
          setupOpts = {
            cmdline = {
              keymap.preset = "cmdline";
              completion.list.selection = {
                preselect = false; # somehow the first was never inserted thus set to false
                auto_insert = true;
              };
            };
          };
        };
        autopairs.nvim-autopairs.enable = true;
      };

    }
  ];
}

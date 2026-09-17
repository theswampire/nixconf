{
  perSystem = { pkgs, ... }: {
    nvfModules = [
      {
        config.vim = {
          languages = {
            rust.enable = true;
          };
          additionalRuntimePaths = [
            ./nvim
          ];
          luaConfigPre = ''
            vim.filetype.add({
              extension = {
                soc = "sockeye",
              },
            })
          '';
        };
      }
    ];
  };
}

{
  perSystem = { lib, ... }: {
    nvfModules = [
      {
        config.vim = {
          lsp.presets = {

            harper.enable = true;
          };
          lsp.servers.harper = {
            filetypes = lib.mkAfter [ "typst" ];
          };
        };
      }
    ];
  };
}

{
  perSystem = {lib, ...}: {
    nvfModules = [
      {
        config.vim = {
          lsp.presets = {
            harper.enable = true;
          };
          lsp.servers.harper = {
            # if the rest should also be checked use this
            # filetypes = lib.mkAfter [ "typst" ];
            filetypes = ["typst"];
          };
        };
      }
    ];
  };
}

{self, ...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: let
    sockeye = self.packages.${pkgs.stdenv.hostPlatform.system}.sockeye;
  in {
    nvfModules = [
      {
        config.vim = {
          lsp.servers.sockeye-analyzer = {
            enable = true;
            cmd = [(lib.getExe' sockeye "sockeye-analyzer")];
            filetypes = ["sockeye"];
            root_markers = [".git"];
          };
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

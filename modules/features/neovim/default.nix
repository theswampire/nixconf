{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.neovim =
    {
      pkgs,
      lib,
      ...
    }:
    {
      environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.myNeovim ];
    };

  perSystem =
    {
      config,
      lib,
      pkgs,
      self',
      ...
    }:
    {
      options.nvfModules = lib.mkOption {
        type = lib.types.listOf lib.types.deferredModule;
        default = [ ];
        description = "List of nvf modules to include in the Neovim package";
      };

      config.packages.myNeovim =
        (inputs.nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = config.nvfModules;
        }).neovim;
    };
}

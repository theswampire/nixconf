{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.neovim = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      self.packages.${stdenv.hostPlatform.system}.myNeovim
      wl-clipboard
    ];
  };

  perSystem =
    {
      config,
      lib,
      pkgs,
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

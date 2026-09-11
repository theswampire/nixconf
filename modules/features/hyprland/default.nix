{ self, inputs, ... }:
{
  flake.nixosModules.hyprland =
    { pkgs, lib, ... }:
    {
      imports = [
        self.nixosModules.noctalia
      	inputs.monique.nixosModules.default
      ];
		
      # monitors / display settings
      programs.monique.enable = true;

      programs.hyprland = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myHyprland;
        xwayland.enable = true;
      };
    };

  perSystem =
    { pkgs, lib, ... }:
    {
      packages.myHyprland = inputs.wrapper-modules.wrappers.hyprland.wrap {
        inherit pkgs;

        configFile = ./hyprland.lua;

      };
    };
}

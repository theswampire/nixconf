{ self, inputs, ... }: {
  flake.nixosModules.noctalia =
    { pkgs, lib, ... }:
    {
      programs.noctalia = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia;

        recommendedServices.enable = true;
      };

      services.displayManager.noctalia-greeter = {
        enable = true;
        settings = {
          cursor.size = 16;
          keyboard.layout = "ch";
        };

        cursorTheme = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
        };
      };
    };

  perSystem = { pkgs, ... }: {
    packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia.wrap {
      inherit pkgs;
      settings = (builtins.fromTOML (builtins.readFile ./noctalia-config.toml));
    };
  };
}

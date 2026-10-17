{ self, ... }: {
  flake.nixosModules.power = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      self.packages.${pkgs.stdenv.hostPlatform.system}.aspm_powerswitch
    ];

    security.wrappers.aspm_powerswitch = {
      enable = true;
      group = "root";
      owner = "root";
      setuid = true;
      source = "${
        self.packages.${pkgs.stdenv.hostPlatform.system}.aspm_powerswitch
      }/bin/aspm_powerswitch";
    };

  };
  perSystem =
    { pkgs, ... }:
    {
      packages.aspm_powerswitch = pkgs.callPackage ../../packages/aspm_powerswitch/package.nix { };
    };
}

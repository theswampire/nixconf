{ self, ... }: {
  flake.nixosModules.power =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.services.aspm_powerswitch;
      aspm_powerswitch = self.packages.${pkgs.stdenv.hostPlatform.system}.aspm_powerswitch;
    in
    {
      options.services.aspm_powerswitch = {
        enable = lib.mkEnableOption "running aspm_powerswitch on boot";

        mode = lib.mkOption {
          type = lib.types.enum [
            "default"
            "performance"
            "powersave"
            "powersupersave"
          ];
          default = "default";
          description = "The power mode argument passed to aspm_powerswitch on boot";
        };
      };

      config = {
        environment.systemPackages = [ aspm_powerswitch ];

        security.wrappers.aspm_powerswitch = {
          enable = true;
          group = "root";
          owner = "root";
          setuid = true;
          source = "${
            self.packages.${pkgs.stdenv.hostPlatform.system}.aspm_powerswitch
          }/bin/aspm_powerswitch";
        };

        systemd.services.aspm_powerswitch-boot = lib.mkIf cfg.enable {
          description = "Run aspm_powerswitch on boot";
          wantedBy = [ "multi-user.target" ];
          after = [ "local-fs.target" ];
          serviceConfig = {
            Type = "oneshot";
            ExecStart = "${aspm_powerswitch}/bin/aspm_powerswitch ${cfg.mode}";
          };
        };

      };
    };
  perSystem =
    { pkgs, ... }:
    {
      packages.aspm_powerswitch = pkgs.callPackage ../../packages/aspm_powerswitch/package.nix { };
    };
}

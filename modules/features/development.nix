{self, ...}: {
  flake.nixosModules.development = {pkgs, ...}: let
    sockeye = self.packages.${pkgs.stdenv.hostPlatform.system}.sockeye;
  in {
    environment.systemPackages = with pkgs; [
      git
      devenv

      cargo
      rustc
      rustfmt
      gcc

      sockeye

      go
      go-task
      air
      sqlc

      pnpm
      nodejs

      z3
      cbmc
      racket

      file
    ];

    environment.shellAliases = {
      gs = "git status";
    };

    virtualisation.docker = {
      enable = true;
      autoPrune = {
        enable = true;
        allVolumes.enable = true;
      };
    };
  };

  perSystem = {pkgs, ...}: {
    packages.sockeye = pkgs.callPackage ../../packages/sockeye/package.nix {};
  };
}

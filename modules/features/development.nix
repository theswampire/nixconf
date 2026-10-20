{
  flake.nixosModules.development = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      git
      devenv

      cargo
      rustc
      gcc

      go
      go-task
      air
      sqlc

      pnpm
      nodejs

      z3
      cbmc
      racket
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
}

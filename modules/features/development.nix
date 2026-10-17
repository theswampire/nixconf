{
  flake.nixosModules.development = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      git
      devenv

      cargo
      rustc
      gcc

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

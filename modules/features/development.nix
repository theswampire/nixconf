{
  flake.nixosModules.development = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      git
      devenv

      cargo
      rustc
      gcc

      z3
      racket-minimal
      cbmc
    ];

    environment.shellAliases = {
      gs = "git status";
    };
  };
}

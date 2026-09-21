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
  };
}

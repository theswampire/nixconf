{
  flake.nixosModules.development = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      git
      devenv

      cargo
      rustc
    ];

    environment.shellAliases = {
      gs = "git status";
    };
  };
}

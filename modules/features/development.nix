{
  flake.nixosModules.development = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      git
      devenv
    ];

    environment.shellAliases = {
      gs = "git status";
    };
  };
}

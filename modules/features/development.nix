{
  flake.nixosModules.development = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [ git ];

    environment.shellAliases = {
      gs = "git status";
    };
  };
}

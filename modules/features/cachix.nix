{
  flake.nixosModules.cachix = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      cachix
    ];

  };
}

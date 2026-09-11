{
  flake.nixosModules.office = { pkgs, ... }: {

    # Office Programs
    environment.systemPackages = with pkgs; [
      evince
      libreoffice
      pdfarranger
      pympress
      thunderbird
    ];
  };
}

{ self, ... }: {
  flake.nixosModules.kaieieiConfiguration = { pkgs, ... }: {

    imports = [
      self.nixosModules.kaieieiHardware

      self.nixosModules.core
      self.nixosModules.desktop
      self.nixosModules.hyprland
      self.nixosModules.kai
      self.nixosModules.neovim
      self.nixosModules.office
      self.nixosModules.remote-build
      self.nixosModules.cachix
      self.nixosModules.development
    ];

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "kaieiei";

    environment.systemPackages = with pkgs; [
      firefox
      vim
    ];

    system.stateVersion = "26.11"; # Did you read the comment?
  };
}

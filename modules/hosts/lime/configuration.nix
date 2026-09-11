{ self, ... }: {

  flake.nixosModules.limeConfiguration = {
    imports = [
      self.nixosModules.limeHardware

      self.nixosModules.core
      self.nixosModules.kai
      self.nixosModules.neovim
      self.nixosModules.server
      self.nixosModules.media
    ];

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    nix.settings.trusted-public-keys = [
      # Update if signing key changes (see remote-build.nix)
      "kaieiei-builder:YLW4BSvWf9TDGrQWQiw2Zc7b7phnril/EV2RzNkCUa8=%"
    ];

    # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
    boot.loader.grub.enable = false;
    # Enables the generation of /boot/extlinux/extlinux.conf
    boot.loader.generic-extlinux-compatible.enable = true;

    # Configure network connections interactively with nmcli or nmtui.
    networking.networkmanager.enable = true;
    networking.hostName = "lime";

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
    # to actually do that.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "23.11"; # Did you read the comment?
  };
}

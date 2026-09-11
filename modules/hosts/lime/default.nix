{ self, inputs, ... }: {
  flake.nixosConfigurations.lime = inputs.nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";

    modules = [
      #inputs.nixos-hardware.nixosModules.raspberry-pi-4
      self.nixosModules.limeConfiguration
    ];
  };
}

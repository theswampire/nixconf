{ self, inputs, ... }: {
  flake.nixosConfigurations.kaieiei = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.kaieieiConfiguration
    ];
  };
}

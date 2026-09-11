{ self, inputs, ... }: {
  flake.nixosConfigurations.eos = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.eosConfiguration

    ];
  };
}

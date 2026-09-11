{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixos-hardware = {
    #  url = "github:nixos/nixos-hardware";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    # until this is merged in, then "github:BirdeeHub/nix-wrapper-modules"
    wrapper-modules.url = "github:jonas-elhs/nix-wrapper-modules/push-kpmnkpssnozs";

    monique.url = "github:ToRvaLDZ/monique";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotASHelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixflix = {
      url = "github:kiriwalawren/nixflix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake {
      inherit inputs;
    } (inputs.import-tree ./modules);
}

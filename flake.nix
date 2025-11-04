{
  description = "A flake for testing nixpkgs modules";

  inputs = {
    nixpkgs.url = "path:/home/pim/cNixos/nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}

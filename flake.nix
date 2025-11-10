{
  description = "A flake for testing nixpkgs modules";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; # GNOME 48
    #nixpkgs.url = "path:/home/pim/cNixos/nixpkgs";

    ## HOME MANAGER
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
        }

        ./_config/configuration.nix
        #./documenso
        ./gnome
      ];
    };
  };
}

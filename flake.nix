{
  description = "NixOS flake configuration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		plugin-github-theme.url = "github:projekt0n/github-nvim-theme";
		plugin-github-theme.flake = false;
  };

  outputs = {self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    { 
    
      nixosConfigurations.saviohc = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };

    };

}

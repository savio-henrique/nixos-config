{
  description = "NixOS flake configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

      nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {self, home-manager, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
      { 
      nixosConfigurations = {
        chrono = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs outputs;};
          modules = [
            ./hosts/chrono
          ];
        };
      };
      homeConfigurations = {
        "chrono@saviohc" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          extraSpecialArgs = {inherit inputs outputs;};
          modules = [./home/saviohc/saviohc.nix];
        };
      };

    };
}

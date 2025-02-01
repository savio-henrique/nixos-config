{
  description = "NixOS flake configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {self, home-manager, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in { 
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      overlays = import ./overlays {inherit inputs;};
      nixosConfigurations = {
        # Personal Desktop
        chrono = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs outputs;};
          modules = [
            ./hosts/chrono
          ];
        };
        # Laptop
        majora = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs outputs;};
          modules = [
            ./hosts/majora
          ];
        };
        # Minecraft Server / Home Server
        cyrus = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs outputs;};
          modules = [
            ./hosts/cyrus
          ];
        };
      };
      homeConfigurations = {
        "saviohc@chrono" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {inherit inputs outputs;};
          modules = [
            ./home/saviohc/chrono.nix 
            ./home/saviohc/saviohc.nix
          ];
        };
        "saviohc@majora" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {inherit inputs outputs;};
          modules = [
            ./home/saviohc/majora.nix 
            ./home/saviohc/saviohc.nix
          ];
        };
        "saviohc@cyrus" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = {inherit inputs outputs;};
          modules = [
            ./home/saviohc/cyrus.nix 
            ./home/saviohc/saviohc.nix
          ];
        };
      };

    };
}

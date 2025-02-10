{base16} : { config, pkgs, inputs, ... }:
{
  # Imports
  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.sops-nix.homeManagerModules.sops
    ../features/cli
    (import ../features/nvim { base16 = base16;})
  ];

  colorScheme = inputs.nix-colors.colorSchemes."${base16}";

  sops = {
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/saviohc/.config/sops/age/keys.txt";
  };

  # User config
  home.username = "saviohc";
  home.homeDirectory = "/home/saviohc";
  # Version
  home.stateVersion = "23.11"; 

  # Nixpkgs config
  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;
}


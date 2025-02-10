{base16} : { config, pkgs, inputs, ... }:
{
  # Imports
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ../features/cli
    (import ../features/nvim { base16 = base16;})
  ];

  colorScheme = inputs.nix-colors.colorSchemes."${base16}";

  # User config
  home.username = "saviohc";
  home.homeDirectory = "/home/saviohc";
  # Version
  home.stateVersion = "23.11"; 

  # Nixpkgs config
  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;
}


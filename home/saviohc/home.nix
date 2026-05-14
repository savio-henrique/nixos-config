{ lib, config, pkgs, inputs, outputs, ... }:
{
  # Imports
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    inputs.stylix.homeModules.stylix
    ../features/cli
    ../features/nvim
  ]++ (builtins.attrValues outputs.homeManagerModules);
  # disabledModules = [
  #   "${inputs.stylix}/modules/waybar/hm.nix"
  #   "${inputs.stylix}/modules/hyprland/hm.nix"
  #   "${inputs.stylix}/modules/hyprlock/hm.nix"
  # ];

  config = {

    nvim = {
      enable = true;
      base16 = config.colorscheme;
    };

    home.file = {
      ".config/wallpapers" = {
        source = ./wallpapers;
        recursive = true;
      };
    };

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
  };
}


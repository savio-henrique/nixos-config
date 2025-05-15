{ lib, config, pkgs, inputs, ... }:
let
  home-cfg = config.home-cfg;
in{
  # Imports
  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.sops-nix.homeManagerModules.sops
    ../features/cli
    ../features/nvim
  ];

  options.home-cfg = {
    base16 = lib.mkOption {
      type = lib.types.str;
      default = "twilight";
      description = "Base16 color scheme to use.";
      example = "default";
    };
  };

  config = {

    nvim = {
      enable = true;
      base16 = home-cfg.base16;
    };

    colorScheme = inputs.nix-colors.colorSchemes."${home-cfg.base16}";

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


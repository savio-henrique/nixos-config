{base16} : { config, pkgs, inputs, ... }:
{
  # Imports
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ../features/cli
    (import ../features/nvim { base16 = base16;})
    # ./programs/freecad/freecad.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes."${base16}";

  # User config
  home.username = "saviohc";
  home.homeDirectory = "/home/saviohc";
  # Version
  home.stateVersion = "23.11"; 

  # Nixpkgs config
  nixpkgs.config.allowUnfree = true;

  # Packages
  # home.packages = with pkgs; [  
  #   ffmpeg
  #   vlc
  #   davinci-resolve
  #   flameshot
  #   discord
  #   vesktop
  #   docker
  #   docker-compose
  #   spotify
  #   brave
  #   helvum
  #
  #   # Utils
  #   onlyoffice-bin
  #   libreoffice
  #   corefonts
  #   unzip
  #   gimp
  #   obsidian
  #
  #   # Widget Utils
  #   acpi
  #   brightnessctl
  #   alsa-utils
  #
  #   # Games
  #   prismlauncher
  #   osu-lazer
  # ];

  # programs.obs-studio = {
  #   enable = true;
  #   plugins = with pkgs; [
  #     obs-studio-plugins.input-overlay
  #     obs-studio-plugins.obs-multi-rtmp
  #     obs-studio-plugins.obs-composite-blur
  #     obs-studio-plugins.obs-move-transition
  #     obs-studio-plugins.obs-pipewire-audio-capture
  #     obs-studio-plugins.obs-teleport
  #   ];
  # };
  programs.home-manager.enable = true;
}


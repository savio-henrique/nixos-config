{ config, pkgs, inputs, ... }:

{
  # Imports
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ../features/cli
    ../features/nvim
    # ./programs/alacritty/alacritty.nix
    # ./programs/freecad/freecad.nix
  ];

  colorScheme = inputs.nix-colors.colorSchemes.twilight;

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
  #   alacritty
  #   neofetch
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

  # File links
  # home.file = with config.colorScheme.palette; {
  #   ".config/neofetch".source = dotfiles/neofetch;
  #   ".config/awesome" = {
  #     source = dotfiles/awesome;
  #     recursive = true;
  #   };
  #
  #   ".config/awesome/awesome-wm-widgets" = {
  #     source = builtins.fetchGit {
  #       url = "https://github.com/streetturtle/awesome-wm-widgets.git";
  #       rev = "68ddbd9812979f1862ebd07f1bf5aa409952e935";
  #     };
  #     recursive = true;
  #   };
  #
  #   ".config/awesome/icons" = {
  #     source = builtins.fetchGit {
  #       url = "https://github.com/streetturtle/awesome-wm-widgets.git";
  #       rev = "68ddbd9812979f1862ebd07f1bf5aa409952e935";
  #     };
  #     recursive = true;
  #   };
  #   
  #   ".config/awesome/theme/colors.lua" = {
  #     target = ".config/awesome/theme/colors.lua";
  #     text = ''
  #       local xresources = require("beautiful.xresources")
  #       local dpi = xresources.apply_dpi
  #       local theme = {}
  #
  #       -- Theme Colors
  #       theme.bg_normal     = "#${base00}"
  #       theme.bg_focus      = "#${base03}"
  #       theme.bg_urgent     = "#${base08}"
  #       theme.bg_minimize   = "#${base02}"
  #       theme.bg_systray    = theme.bg_normal
  #       
  #       theme.fg_normal     = "#${base06}"
  #       theme.fg_focus      = "#${base07}"
  #       theme.fg_urgent     = "#${base07}"
  #       theme.fg_minimize   = "#${base07}"
  #
  #       theme.useless_gap   = dpi(4)
  #       theme.border_width  = dpi(2)
  #       theme.border_normal = "#${base0F}"
  #       theme.border_focus  = "#${base09}"
  #       theme.border_marked = "#${base0E}"
  #       
  #       theme.titlebar_bg_color  = theme.border_focus
  #       theme.titlebar_fg_color  = theme.border_focus
  #
  #       theme.tasklist_bg_focus  = theme.border_focus
  #       theme.tasklist_bg_normal = theme.border_normal
  #       theme.taglist_bg_normal  = theme.border_normal
  #       theme.taglist_bg_focus   = theme.border_focus
  #       
  #       return theme
  #     '';
  # 	};
  # };

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
  # services.flameshot.enable = true;
  programs.home-manager.enable = true;
}


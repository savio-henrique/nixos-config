{
  config,
  lib,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ../features/awesome
    ../features/alacritty.nix
    ../features/vesktop
    ../features/obs
  ];
  awesome.enable = true;


  home.packages = with pkgs; [
    # Tools
    pavucontrol
    pcmanfm
    dmenu
    libreoffice
    corefonts

    # Applications
    spotify
    brave
    firefox
    obsidian
    flameshot
    vlc
    gimp
  ];
}

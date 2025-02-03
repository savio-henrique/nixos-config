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
    rofi
    dmenu
    pcmanfm
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

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
  ];

  home.packages = with pkgs; [
    # Tools
    pavucontrol
    xterm
    rofi
    dmenu
    pcmanfm
    libreoffice

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

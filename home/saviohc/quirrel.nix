{ inputs, pkgs, config, ... }: 
{ 
  imports = [ 
    ./home.nix
    ../common 
    ../common/visual 
  ]; 

  # Change the base16  theme for the host
  colorscheme = "da-one-sea";

  visual.runner = "rofi -show drun";
  visual.environment = "hyprland";

  home.packages = builtins.attrValues { inherit (pkgs)
    vivaldi
    devenv
    calibre
    obsidian
    zotero
    vscode
    discord;
  } ++ [ 
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  monitors = [
    {
      name = "eDP-1";
      width = 1920;
      height = 1080;
      workspace = 1;
      primary = true;
      position = "1920x0";
      refreshRate = 120;
      scale = 1.0;
    }
    {
      name = "HDMI-A-1";
      width = 1920;
      height = 1080;
      workspace = 2;
      primary = false;
      position = "0x0";
      refreshRate = 60;
      scale = 1.0;
    }
  ];
  wallpaper = "hollow-knight-2.jpg";
  wallpaperPath = "${config.home.homeDirectory}/.config/wallpapers/${config.wallpaper}";
}

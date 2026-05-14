{pkgs, config, ... }: 
{ 
  imports = [ 
    ./home.nix
    ../common 
    ../common/visual
  ]; 

  # Change the base16  theme for the host
  colorscheme = "uwunicorn";

  visual.runner = "rofi -show drun";
  visual.environment = "hyprland";

  home.packages = builtins.attrValues { inherit (pkgs)
    davinci-resolve
    prismlauncher
    calibre
    dbeaver-bin
    vivaldi
    element-desktop
    zotero
    bruno
    audacity
    devenv
    vscode
    discord;
  };

  monitors = [
    {
      name = "HDMI-0";
      width = 2560;
      height = 1080;
      workspace = 1;
      primary = true;
      refreshRate = 75;
      scale = 1.0;
    }
  ];

  wallpaper = "evangelion_1.jpg";
  wallpaperPath = "${config.home.homeDirectory}/.config/wallpapers/${config.wallpaper}";
}

{pkgs, config, ... }: 
{ 
  imports = [ 
    ./home.nix
    ../common 
    ../common/visual
  ]; 

  # Change the base16  theme for the host
  home-cfg.base16 = "uwunicorn";

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

  wallpaper = "${config.home.homeDirectory}/.config/wallpapers/evangelion_1.jpg";
}

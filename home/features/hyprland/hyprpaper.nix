{config, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true;
      splash = false;
      preload = "${config.visual.backgroundPath}/${config.home-cfg.background}";
      wallpaper = "${config.visual.backgroundPath}/${config.home-cfg.background}";
    };
  };
}

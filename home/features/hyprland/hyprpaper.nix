{config, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true;
      splash = false;
      preload = [
        "${config.wallpaperPath}"
      ];
      wallpaper = {
        monitor = ""; # All monitors
        path = "${config.wallpaperPath}";
      };
    };
  };
}

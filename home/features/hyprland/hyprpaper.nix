{config, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true;
      splash = false;
      preload = [
        "${config.wallpaper}"
      ];
      wallpaper = {
        monitor = ""; # All monitors
        path = "${config.wallpaper}";
      };
    };
  };
}

{config, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true;
      splash = false;
      wallpaper = {
        monitor = ""; # All monitors
        path = "${config.wallpaper}";
      };
    };
  };
}

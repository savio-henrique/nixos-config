{lib, ...}: let
  inherit (lib) types mkOption;
in {
  options = {
    wallpaper = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = ''
        Wallpaper filename
      '';
    };
    wallpaperPath = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = ''
        Wallpaper directory path
      '';
    };
  };
}

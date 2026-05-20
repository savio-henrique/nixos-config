{lib, ...}: let
  inherit (lib) types mkOption;
in {
  options.colorscheme = mkOption {
    type = types.str;
    default = "twilight";
    description = ''
      Base16 Colorscheme Name
    '';
  };
}


{lib, ...}: let
  inherit (lib) types mkOption;
in {
  options.colorscheme = mkOption {
    type = types.nullOr types.str;
    default = null;
    description = ''
      Base16 Colorscheme Name
    '';
  };
}

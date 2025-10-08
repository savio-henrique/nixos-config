{lib, inputs, config, outputs, pkgs, ...}:
let
  nix-colors-lib = inputs.nix-colors.lib.contrib { inherit pkgs; };
in {
  home.packages = [pkgs.dconf];
  gtk = {
    enable = true;
    theme = {
      name = config.colorScheme.slug;
      package = nix-colors-lib.gtkThemeFromScheme {  
        scheme = config.colorScheme;
      };
    };
  };
}

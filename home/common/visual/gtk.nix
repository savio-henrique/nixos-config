{lib, inputs, config, outputs, pkgs, ...}:
let
  nix-colors-lib = inputs.nix-colors.lib.contrib { inherit pkgs; };
in {
  gtk = {
    enable = true;
    theme = {
      name = "generated-theme";
      package = nix-colors-lib.gtkThemeFromScheme {  
        scheme = config.colorScheme;
      };
    };
  };
}

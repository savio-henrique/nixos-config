{pkgs, config, lib, ... }:
{
  home.packages = with pkgs; [
    rofi
  ];

  home.file = with config.colorScheme.palette; {
    ".config/rofi" = {
      source = ./config;
      recursive = true;
    };

    ".config/rofi/theme.rasi" = {
      target = ".config/rofi/theme.rasi";
      text = ''
        * {
          bg: #${base00};
          bg-alt: #${base02};

          fg: #${base09};
          fg-alt: #${base0F};

          text: #${base08};

          background-color: @bg;

          border: 0;
          margin: 0;
          padding: 0;
          spacing: 0;
        }
      '';
    };
  };
}

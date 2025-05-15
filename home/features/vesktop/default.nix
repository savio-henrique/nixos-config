{ config, pkgs, inputs, ...}:
{
  home.packages = with pkgs; [
    vesktop
  ];

  home.file = with config.colorScheme.palette; {
    ".config/vesktop/settings.json" = {
      target = ".config/vesktop/settings.json";
      source = ./config/settings.json;
    };

    ".config/vesktop/settings" = {
      source = ./config/settings;
      recursive = true;
    };

    ".config/vesktop/themes" = {
      source = ./config/themes;
      recursive = true;
    };

    ".config/vesktop/themes/hokusai.theme.css" = {
      target = ".config/vesktop/themes/hokusai.theme.css";
      # Copied and altered from Nocturnal Theme
      text = ''
/**
* @name Nocturnal/Altered
* @version 1.0.0
* @description My own modification of the Nocturnal theme
* @author Spectra + Hokusai
* @source https://github.com/xcruxiex/themes
* @website https://betterdiscord.app/theme/Nocturnal
*/
@import url("https://xcruxiex.github.io/themes/themes-cores/nocturnal.css");

@import url("https://xcruxiex.github.io/themes/core/badges.css");
@import url("https://xcruxiex.github.io/themes/core/custom-font.css");
@import url("https://discordstyles.github.io/RadialStatus/dist/RadialStatus.css"); /* Radial Status */
@import url("https://xcruxiex.github.io/themes/core/settings-icons.css");
:root {
    --backgroundColor01: #${base02} ;
    --backgroundColor02: #${base01};
    --mainColor: #${base09};
    --gradientColor01: #${base09};
    --gradientColor02: #${base0A};

    /* Better Hljs */
    --backgroundCode: #${base03};
    --backgroundName: rgba(0, 0, 0, 0.2);

    /* Radial Status */
    --rs-small-spacing: 2px;
    --rs-large-spacing: 3px;
    --rs-width: 2px;
    --rs-avatar-shape: 50%;
    --rs-online-color: #${base0B};
    --rs-idle-color: #${base0F};
    --rs-dnd-color: #${base08};
    --rs-offline-color: #${base04};
    --rs-streaming-color: #${base0E};
    --rs-invisible-color: #${base06};
    --rs-phone-visible: block;
    --rs-phone-color: var(--rs-online-color);

    /* Unread Animation :
    none -> static point.
    pulse -> pulsating point
    */
    --unread-animation: pulse;

    --customFont: "gg sans", sans-serif;
}
      '';
    };
  };
}

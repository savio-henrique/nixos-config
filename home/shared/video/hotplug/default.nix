{ lib, config, pkgs, ... }:

let
  cfg = config.hotplug;
in
{
  options.hotplug = {
    enable = lib.mkEnableOption "enable awesomewm monitor hotplug module";
  };

  config = lib.mkIf cfg.enable {

    services.udev.extraRules = 
      let 
        # notify-awesome code from https://github.com/dluksza/screenful
        notifyAwesome = pkgs.writeShellApplication {
          name = "notify-awesome";
          text = ''
            #!/bin/sh

            _PID=$(pgrep -x awesome)
            _UID=$(ps -o uid= -p "$_PID")
            USER=$(id -nu "$_UID")
            DBUS_ADDRESS_VAR=$(cmd < /proc/"$_PID"/environ | grep -z "^DBUS_SESSION_BUS_ADDRESS=")

            notify() {
              su - "$USER" -c "/bin/bash \
                -c ' \
                    export DISPLAY=:0; \
                    export XAUTHORITY='/home/$USER/.Xauthority'; \
                    export $DBUS_ADDRESS_VAR; \
                    dbus-send --dest=org.awesomewm.awful --type=method_call \
                      / org.awesomewm.awful.Remote.Eval string:\"updateScreens\(""$1""\)\" \

                ' \
                  "
                }

            notify "$1" &
          '';
        }; in ''
        ACTION=="change", SUBSYSTEM=="drm", RUN+="${notifyAwesome} %k"
      '';
    };
}

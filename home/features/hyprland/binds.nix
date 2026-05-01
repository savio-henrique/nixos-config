{lib, config, ...}: {
  wayland.windowManager.hyprland.settings = {
    bindm = [
      "$mod ,mouse:272,movewindow"
      "$mod ,mouse:273,resizewindow"
    ];

    bind = let
      workspaces = [
        "0"
        "1"
        "2"
        "3"
        "4"
        "5"
        "6"
        "7"
        "8"
        "9"
      ];
      # Map keys (arrows and hjkl) to hyprland directions (l, r, u, d)
      directions = rec {
        left = "l";
        right = "r";
        up = "u";
        down = "d";
        h = left;
        l = right;
        k = up;
        j = down;
      };
    in
      [
        "$mod SHIFT,q,killactive"
        "$mod SHIFT,e,exit"

        "$mod ,s,togglesplit"
        "$mod ,f,fullscreen,1"
        "$mod SHIFT,f,fullscreen,0"
        "$mod SHIFT,space,togglefloating"

        "$mod ,minus,splitratio,-0.25"
        "$mod SHIFT,minus,splitratio,-0.3333333"

        "$mod ,equal,splitratio,0.25"
        "$mod SHIFT,equal,splitratio,0.3333333"

        "$mod ,g,togglegroup"
        "$mod ,t,lockactivegroup,toggle"
        "$mod ,tab,changegroupactive,f"
        "$mod SHIFT,tab,changegroupactive,b"

        "$mod ,apostrophe,workspace,previous"
        "$mod SHIFT,apostrophe,workspace,next"
        "$mod ,dead_grave,workspace,previous"
        "$mod SHIFT,dead_grave,workspace,next"

        "$mod ,u,togglespecialworkspace"
        "$mod ,n,movetoworkspacesilent,special"
        "$mod ,y,toggleswallow"
        "$mod ,i,pin"
        "$mod ,i,fullscreenstate,0 3"
      ]
      ++
      # Change workspace
      (map (n: "$mod ,${n},workspace,${n}") workspaces)
      ++
      # Move window to workspace
      (map (n: "$mod SHIFT,${n},movetoworkspacesilent,${n}") workspaces)
      ++
      # Move focus
      (lib.mapAttrsToList (key: direction: "$mod ,${key},movefocus,${direction}") directions)
      ++
      # Swap windows
      (lib.mapAttrsToList (key: direction: "$mod SHIFT,${key},swapwindow,${direction}") directions)
      ++
      # Move windows
      (lib.mapAttrsToList (
          key: direction: "$mod CONTROL,${key},movewindow,${direction}"
        )
        directions)
      ++
      # Move monitor focus
      (lib.mapAttrsToList (key: direction: "$mod ALT,${key},focusmonitor,${direction}") directions)
      ++
      # Move workspace to other monitor
      (lib.mapAttrsToList (
          key: direction: "$mod CONTROLSHIFT,${key},movecurrentworkspacetomonitor,${direction}"
        )
        directions);
  };
}

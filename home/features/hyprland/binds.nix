{lib, config, ...}: {
  wayland.windowManager.hyprland.settings = let
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
        left = "left";
        right = "right";
        up = "up";
        down = "down";
        h = left;
        l = right;
        k = up;
        j = down;
      };
    in {

      # Create workspaces
      workspace_rule = let
        valid_workspaces = builtins.filter (x: (builtins.foldl' (z: y: if y.workspace == x then z + 1 else z) 0 config.monitors) == 0 ) workspaces;
      in
      (map (n: {
        _args = [
          (lib.generators.mkLuaInline "{workspace = \"${n}\", persistent = true}")
        ];
      }) valid_workspaces) ++
      (map (m: if m.enabled then {
        _args = [
          (lib.generators.mkLuaInline "{workspace = \"${m.workspace}\", monitor = \"${m.name}\", persistent = true}")
        ];
      } else {}) config.monitors);

      bind = [
        # Drag Window
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + mouse:272\"")
            (lib.generators.mkLuaInline "hl.dsp.window.drag()")
          ];
        }
        # Resize Window
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + mouse:273\"")
            (lib.generators.mkLuaInline "hl.dsp.window.resize()")
          ];
        }
        # Kill Window
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + C\"")
            (lib.generators.mkLuaInline "hl.dsp.window.kill()")
          ];
        }
        # Logout from Hyprland
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + Q\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"logout\")")
          ];
        }
        # Quit Hyprland
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + E\"")
            (lib.generators.mkLuaInline "hl.dsp.exit()")
          ];
        }

        # Toggle split layout
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + S\"")
            (lib.generators.mkLuaInline "hl.dsp.layout(\"togglesplit\")")
          ];
        }
        # Toggle floating layout
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + S\"")
            (lib.generators.mkLuaInline "hl.dsp.layout(\"togglefloating\")")
          ];
        }
        # Set Fullscreen
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + F\"")
            (lib.generators.mkLuaInline "hl.dsp.window.fullscreen({ action = \"set\", mode = \"fullscreen\"})")
          ];
        }
        # Toggle Fullscreen
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + F\"")
            (lib.generators.mkLuaInline "hl.dsp.window.fullscreen({ action = \"toggle\"})")
          ];
        }
        # Toggle Floating Window
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + SPACE\"")
            (lib.generators.mkLuaInline "hl.dsp.window.float()")
          ];
        }

        # Change split ratio minus 0.25
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + MINUS\"")
            (lib.generators.mkLuaInline "hl.dsp.layout(\"splitratio -0.25\")")
          ];
        }
        # Change split ratio minus 0.33
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + MINUS\"")
            (lib.generators.mkLuaInline "hl.dsp.layout(\"splitratio -0.3333333\")")
          ];
        }
        # Change split ratio plus 0.25
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + EQUAL\"")
            (lib.generators.mkLuaInline "hl.dsp.layout(\"splitratio 0.25\")")
          ];
        }
        # Change split ratio plus 0.33
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + EQUAL\"")
            (lib.generators.mkLuaInline "hl.dsp.layout(\"splitratio 0.3333333\")")
          ];
        }
        # Change split ratio to exact 1
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + CONTROL + EQUAL\"")
            (lib.generators.mkLuaInline "hl.dsp.layout(\"splitratio 1 exact\")")
          ];
        }

        # Toggle active Group
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + G\"")
            (lib.generators.mkLuaInline "hl.dsp.group.toggle()")
          ];
        }
        # Toggle lock active Group
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + T\"")
            (lib.generators.mkLuaInline "hl.dsp.group.lock()")
          ];
        }
        # Change active Group to next
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + TAB\"")
            (lib.generators.mkLuaInline "hl.dsp.group.next()")
          ];
        }
        # Change active Group to previous
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + TAB\"")
            (lib.generators.mkLuaInline "hl.dsp.group.prev()")
          ];
        }

        # Open minimized workspace
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + U\"")
            (lib.generators.mkLuaInline "hl.dsp.workspace.toggle_special(\"minimized\")")
          ];
        }
        # Move window to minimized workspace
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + N\"")
            (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = \"special:minimized\", follow = false })")
          ];
        }
        # Toggle swallow window
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + Y\"")
            (lib.generators.mkLuaInline "hl.dsp.window.toggle_swallow()")
          ];
        }
        # Pin window to workspace
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + I\"")
            (lib.generators.mkLuaInline "hl.dsp.window.pin()")
          ];
        }
        # Change Workspace with Mouse Whell
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + mouse_up\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = \"e-1\"})")
          ];
        }
        # Change Workspace with Mouse Whell
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + mouse_down\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = \"e+1\"})")
          ];
        }
      ]
      ++
      # Change workspace
      (map (n: {
        _args = [
          (lib.generators.mkLuaInline "mod .. \" + ${n}\"")
          (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = \"${n}\"})")
        ];
      }) workspaces)
      ++
      # Move window to workspace
      (map (n: {
        _args = [
          (lib.generators.mkLuaInline "mod .. \" + SHIFT + ${n}\"")
          (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = \"${n}\", follow = false })")
        ];
      }) workspaces)
      ++
      # Move focus
      (lib.mapAttrsToList (key: direction:
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + ${key}\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"${direction}\"})")
          ];
        }
      ) directions)
      ++
      # Swap windows
      (lib.mapAttrsToList (key: direction:
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + ${key}\"")
            (lib.generators.mkLuaInline "hl.dsp.window.swap({ direction = \"${direction}\"})")
          ];
        }
      ) directions)
      ++
      # Move windows
      (lib.mapAttrsToList (key: direction:
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + CONTROL + ${key}\"")
            (lib.generators.mkLuaInline "hl.dsp.window.move({ direction = \"${direction}\"})")
          ];
        }
      ) directions);
  };
}

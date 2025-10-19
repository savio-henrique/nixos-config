{
  imports = [
    ../common/global
    ../common/optional/video.nix
    ../common/optional/containers
    ./configuration.nix
  ];

  video.enable = true;
  video.dual = true;
  video.environment = "awesome";

  oci-config = {
    enable = true;
    engine = "docker";
    rootless = false;
  };

  # Keyboard Remap Config
  services.xremap = {
    enable = true;
    userName = "saviohc";
    withX11 = true;
    deviceNames = [ "USB-HID Gaming Keyboard" ];
    config = {
      modmap = [
        {
          name = "gamepad";
          remap = {
            "KEY_J" = "KEY_LEFT";
            "KEY_L" = "KEY_RIGHT";
            "KEY_I" = "KEY_UP";
            "KEY_K" = "KEY_DOWN";
            "KEY_BACKSLASH" = { set_mode = "default";};
          };
          mode = "gamepad";
        }
      ];
      keymap = [
        {
          name = "default";
          remap = {
            "C-BACKSLASH" = { set_mode = "gamepad";};
            };
          mode = "default";
        }
        {
          name = "gamepad";
          remap = {
            "C-BACKSLASH" = { set_mode = "default";};
            };
          mode = "gamepad";
        }
      ];
      default_mode = "default";
    };
  };

  # VM test configuration
  # virtualisation.vmVariant = {
  #   virtualisation = {
  #     memorySize = 8192; # 8 GB
  #     cores = 2;
  #   };
  # };

  services.tailscale.enable = true;
}

{ config, lib, ...}:
let 
  cfg = config.incus;
in {
  options.incus = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable incus.";
    };
    config = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Configuration for incus."; 
    };
  };

  config = lib.mkIf cfg.enable {
    # Incus Config
    virtualisation.incus = {
      enable = true;
      ui.enable = false;
      preseed = cfg.config;
    };

    # Networking Config
    networking.nftables.enable = true;
  };
}

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
  };

  config = lib.mkIf cfg.enable {
    # Incus Config
    virtualisation.incus.enable = true;

    # Networking Config
    networking.nftables.enable = true;
  };
}

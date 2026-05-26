{pkgs, config, lib, ...}:
let 
  cfg = config.kubernetes;
in {
  imports = [
    ../containers
  ];
  options.kubernetes = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable k8s.";
    };

    distro = lib.mkOption {
      type = lib.types.enum [ "k3s" "kind" ];
      default = "k3s";
      description = "The k8s image to use.";
    };
  };

  config = lib.mkIf cfg.enable {
    # K3s Config
    services.k3s.enable = cfg.distro == "k3s";

    # Kind Config
    environment.systemPackages = lib.mkIf (cfg.distro == "kind") [
      pkgs.kind
      pkgs.kubectl
    ];

    oci-config.enable = cfg.distro == "kind";
    oci-config.engine = lib.mkIf (cfg.distro == "kind") "docker";
  };
}

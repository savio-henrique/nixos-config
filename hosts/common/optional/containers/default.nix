{pkgs, config, lib, ...}:
let 
  oci-config = config.oci-config;
in {
  imports = [
    ./homepage
  ];

  options.oci-config = {
    enable = lib.mkOption {
      default = true;
      type = lib.types.bool;
      description = "Enable OCI containers";
    };

    engine = lib.mkOption {
      default = "docker";
      type = lib.types.str;
      description = "Container engine to use";
    };

    rootless = lib.mkOption {
      default = true;
      type = lib.types.bool;
      description = "Enable rootless containers";
    };

    network = lib.mkOption {
      default = "homelab-network";
      type = lib.types.str;
      description = "Docker network to use";
    };

    cloudflare = {
      enable = lib.mkOption {
        default = false;
        type = lib.types.bool;
        description = "Enable Cloudflared tunneling";
      };
    };

    firefly-iii = {
      enable = lib.mkOption {
        default = false;
        type = lib.types.bool;
        description = "Enable Firefly III";
      };

      port = lib.mkOption {
        default = 8080;
        type = lib.types.int;
        description = "Port for Firefly III";
      };
    };

    pi-hole = {
      enable = lib.mkOption {
        default = false;
        type = lib.types.bool;
        description = "Enable Pi-Hole";
      };
    };

    trilium = {
      enable = lib.mkOption {
        default = false;
        type = lib.types.bool;
        description = "Enable Trilium";
      };

      port = lib.mkOption {
        default = 8080;
        type = lib.types.int;
        description = "Port for Trilium";
      };

      dir = lib.mkOption {
        default = "/var/lib/trilium-data";
        type = lib.types.path;
        description = "Directory for Trilium data";
      };
    };

    homepage = {
      enable = lib.mkOption {
        default = false;
        type = lib.types.bool;
        description = "Enable Homepage";
      };
      dir = lib.mkOption {
        default = "/var/lib/homepage";
        type = lib.types.path;
        description = "Directory for homepage configuration";
      };
    };

    vaultwarden = {
      enable = lib.mkOption {
        default = false;
        type = lib.types.bool;
        description = "Enable Vaultwarden";
      };

      port = lib.mkOption {
        default = 8080;
        type = lib.types.int;
        description = "Port for Vaultwarden";
      };

      dir = lib.mkOption {
        default = "/var/lib/vaultwarden";
        type = lib.types.path;
        description = "Directory for Vaultwarden data";
      };

    };

    grafana = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "Enable Grafana";
    };

    miniflux = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "Enable Miniflux";
    };

  };

  config = lib.mkIf oci-config.enable {
    # Create Docker network
    systemd.services.dockerSetup = let 
      script = pkgs.writeShellScriptBin "network-setup" ''
        #!/usr/bin/env bash
        set -euo pipefail
        # Create the Docker network
        ${pkgs.docker}/bin/docker network create --driver bridge ${oci-config.network} || true
      '';
      in lib.mkIf (oci-config.engine == "docker") {
      description = "Docker Network Setup";
      wantedBy =  [ "multi-user.target" ];
      serviceConfig = { 
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = ''${script}/bin/network-setup'';
      };
    };

    # Enable OCI containers
    virtualisation.${oci-config.engine} = {
      enable = true;
    } // lib.optionalAttrs (oci-config.engine=="docker" && oci-config.rootless) {
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    virtualisation.oci-containers = {
      backend = oci-config.engine;
      containers = let
        # Import container modules
        firefly = (import ./firefly.nix {inherit config; port = builtins.toString oci-config.firefly-iii.port; network = oci-config.network;});
        pi-hole = (import ./pi-hole.nix {inherit config; network = oci-config.network;});
        trilium = (import ./trilium-next.nix {inherit config; port = builtins.toString oci-config.trilium.port; dir = oci-config.trilium.dir; network = oci-config.network;});
        homepage-container = (import ./homepage.nix {inherit config; dir = oci-config.homepage.dir; network = oci-config.network;});
        vaultwarden = (import ./vaultwarden.nix {inherit config; port = builtins.toString oci-config.vaultwarden.port; dir = oci-config.vaultwarden.dir; network = oci-config.network;});
         cloudflare = (import ./cloudflare.nix {inherit config; network = oci-config.network;});
      in {}
        # Firefly III
      // lib.optionalAttrs (oci-config.firefly-iii.enable) {
        firefly_iii_core = firefly.firefly_iii_core;
        firefly_iii_db = firefly.firefly_iii_db;
        #firefly_iii_cron = firefly.firefly_iii_cron;
      }
        # Pi-Hole
      // lib.optionalAttrs (oci-config.pi-hole.enable) {
        pi-hole = pi-hole.pi-hole;
        unbound = pi-hole.unbound;
      }
        # Trilium
      // lib.optionalAttrs (oci-config.trilium.enable) {
        trilium_server = trilium.trilium_server;
      }
        # Homepage
      // lib.optionalAttrs (oci-config.homepage.enable) {
        homepage = homepage-container.homepage;  
      }
        # Vaultwarden
      // lib.optionalAttrs (oci-config.vaultwarden.enable) {
        vaultwarden = vaultwarden.vaultwarden;
        vaultwarden_db = vaultwarden.vaultwarden_db;
      }
        # Cloudflare
      // lib.optionalAttrs (oci-config.cloudflare.enable) {
        cloudflared = cloudflare.cloudflared;
      };
    };

    # Enable systemd services for Homepage Configuration
    homepage = {
      enable = oci-config.homepage.enable;
      config-dir = oci-config.homepage.dir;
    };
  };
}

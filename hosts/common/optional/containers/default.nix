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

    updates = {
      enable = lib.mkOption {
        default = true;
        type = lib.types.bool;
        description = "Enable automatic updates for OCI containers";
      };
      schedule = lib.mkOption {
        default = "Mon 04:00"; # Every Monday at 4 AM
        type = lib.types.str;
        description = "Cron schedule for automatic updates (in cron format)";
      };
      restartsAt = lib.mkOption {
        default = "Tue 04:00"; # Every Tuesday at 4 AM
        type = lib.types.str;
        description = "Cron schedule for automatic container restarts (in cron format)";
      };
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

    grafana = {
      enable = lib.mkOption {
        default = false;
        type = lib.types.bool;
        description = "Enable Grafana";
      };
      port = lib.mkOption {
        default = 3000;
        type = lib.types.int;
        description = "Port for Grafana";
      };
    };

    prometheus = {
      enable = lib.mkOption {
        default = false;
        type = lib.types.bool;
        description = "Enable Prometheus";
      };
      port = lib.mkOption {
        default = 9090;
        type = lib.types.int;
        description = "Port for Prometheus";
      };
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
      autoPrune = {
        enable = true;
        flags = [ "--all" ];
      };
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
        prometheus = (import ./prometheus.nix {inherit config; port = builtins.toString oci-config.prometheus.port; network = oci-config.network;});
        grafana = (import ./grafana.nix {inherit config; port = builtins.toString oci-config.grafana.port; network = oci-config.network;});
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
      }
      # Prometheus
      // lib.optionalAttrs (oci-config.prometheus.enable) {
        prometheus = prometheus.prometheus;
      }
        # Grafana
      // lib.optionalAttrs (oci-config.grafana.enable) {
        grafana = grafana.grafana;
      };
    };

    # Enable systemd services for Homepage Configuration
    homepage = {
      enable = oci-config.homepage.enable;
      config-dir = oci-config.homepage.dir;
    };

    # Enable automatic updates for OCI containers
    # Systemd timer for updating containers
    systemd.timers.oci-container-updates = lib.mkIf oci-config.updates.enable {
      description = "Timer for OCI Container Updates";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        Unit = "oci-container-updates.service";
        OnCalendar = oci-config.updates.schedule;
        Persistent = true;
      };
    };

    # Systemd service for updating containers
    systemd.services.oci-container-updates = lib.mkIf oci-config.updates.enable {
      description = "OCI Container Updates";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = lib.getExe (pkgs.writeShellScriptBin "oci-container-updates" ''
          images=$(${pkgs.${oci-config.engine}}/bin/${oci-config.engine} ps --format "{{.Image}}" | sort -u)

          for image in $images; do
            ${pkgs.${oci-config.engine}}/bin/${oci-config.engine} pull "$image"
          done
        '');
      };
    };

    # Restart Containers
    systemd.timers.oci-container-restart = lib.mkIf oci-config.updates.enable {
      description = "Timer for OCI Container Restart";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        Unit = "oci-container-restart.service";
        OnCalendar = oci-config.updates.restartsAt;
        Persistent = true;
      };
    };

    systemd.services.oci-container-restart = lib.mkIf oci-config.updates.enable {
      description = "OCI Container Restart";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = lib.getExe (pkgs.writeShellScriptBin "oci-container-restart" ''
          containers=$(${pkgs.systemd}/bin/systemctl list-units | grep .service | grep ${oci-config.engine}- | awk -F' ' '{print $1}' | sort -u)

          for container in $containers; do
            ${pkgs.systemd}/bin/systemctl try-restart "$container"
          done
        '');
      };
    };
  };
}

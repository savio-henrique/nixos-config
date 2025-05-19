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

    vaultwarden = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "Enable Vaultwarden";
    };
  };

  config = lib.mkIf oci-config.enable {
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
        firefly = (import ./firefly.nix {inherit config; port = builtins.toString oci-config.firefly-iii.port;});
        pi-hole = (import ./pi-hole.nix {inherit config;});
        trilium = (import ./trilium-next.nix {inherit config; port = builtins.toString oci-config.trilium.port; dir = oci-config.trilium.dir;});
        homepage-container = (import ./homepage.nix {inherit config; dir = oci-config.homepage.dir;});
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
      };
    };

    homepage = {
      enable = oci-config.homepage.enable;
      config-dir = oci-config.homepage.dir;
    };
  };
}

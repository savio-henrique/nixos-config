{pkgs, config, lib, ...}:
let 
  oci-config = config.oci-config;
in {
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

    pi-hole = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "Enable Pi-Hole";
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

    homepage = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "Enable Homepage";
    };

    vaultwarden = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "Enable Vaultwarden";
    };
  };

  config = lib.mkIf oci-config.enable {
    virtualisation.${oci-config.engine}.enable = true;
    virtualisation.${oci-config.engine} = lib.mkIf (oci-config.engine == "docker") { 
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    virtualisation.oci-containers = {
      backend = oci-config.engine;
      containers = {}
        # Firefly III
        // lib.optionalAttrs (oci-config.firefly-iii.enable) {
          firefly_iii_core = import ./containers/firefly-iii-core.nix {inherit config; port = builtins.toString oci-config.firefly-iii.port;};
          firefly_iii_db = import ./containers/firefly-iii-db.nix {inherit config;};
          #firefly_iii_cron = import ./containers/firefly-iii-cron.nix {inherit config;};

          };
    };

  };
}

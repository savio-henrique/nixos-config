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
    virtualisation.${oci-config.engine} = if (oci-config.engine == "docker") then {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    } else {
      enable = true;
    };

    virtualisation.oci-containers = {
      backend = oci-config.engine;
      containers = let
        firefly =  (import ./firefly {inherit config; port = builtins.toString oci-config.firefly-iii.port;});
      in {}
        # Firefly III
      // lib.optionalAttrs (oci-config.firefly-iii.enable) {
        firefly_iii_core = firefly.firefly_iii_core;
        firefly_iii_db = firefly.firefly_iii_db;
        #firefly_iii_cron = firefly.firefly_iii_cron;

          };
    };

  };
}

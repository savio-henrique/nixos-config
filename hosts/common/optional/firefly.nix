{ lib, pkgs, config , ... }:
{
  # Configure SOPS
  sops.secrets = {
    firefly-key = {
      sopsFile = ./secrets.yaml;
      neededForUsers = true;
    };

    firefly-db-password= {
      sopsFile = ./secrets.yaml;
      neededForUsers = true;
    };
  };

  # Configure Firefly III
  services.nginx = {
    enable = true;
    virtualHosts.${config.services.firefly-iii.virtualHost}.listen = [ {
      addr = "0.0.0.0";
      port = 80;
    } ];
  };

  services.firefly-iii = {
    enable = true;
    enableNginx = true;
    virtualHost = "0.0.0.0";
    settings = {
      APP_ENV = "production"; 
      APP_KEY_FILE = config.sops.secrets.firefly-key.path;
      DB_CONNECTION = "pgsql";
      DB_HOST = "localhost";
      DB_PORT = 5432;
      DB_DATABASE = "firefly";
      DB_USERNAME = "firefly";
      DB_PASSWORD_FILE = config.sops.secrets.firefly-db-password.path;
    };
  };

  # Configure PostgreSQL Container
  virtualisation.docker.enable = true;

  virtualization.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers.firefly-db = {
      image = "postgres:latest";
      autoStart = true;
      ports = [ { hostPort = 5432; containerPort = 5432; } ];
      volumes = [
        {
          hostPath = "/var/lib/postgresql/data";
          containerPath = "/var/lib/postgresql/data";
        }
      ];
      environment = {
        POSTGRES_USER = "firefly";
        POSTGRES_PASSWORD_FILE = config.sops.secrets.firefly-db-password.path;
        POSTGRES_DB = "firefly";
      };
    };
  };
}

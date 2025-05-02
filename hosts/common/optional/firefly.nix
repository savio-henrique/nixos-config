{ lib, pkgs, config , ... }:
{
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

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers.firefly-db = {
      image = "postgres:latest";
      autoStart = true;
      ports = ["5432:5432"];
      volumes = [
          (config.sops.secrets.firefly-db-password.path + ":/run/secrets/firefly-db-password:ro")
          "/var/lib/postgresql/data:/var/lib/postgresql/data"
      ];
      environment = {
        POSTGRES_USER = "firefly";
        POSTGRES_PASSWORD_FILE = config.sops.secrets.firefly-db-password.path;
        POSTGRES_DB = "firefly";
      };
    };
  };
}

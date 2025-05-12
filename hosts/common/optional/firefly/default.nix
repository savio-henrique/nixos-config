{ lib, pkgs, config , ... }:
{

  # services.firefly-iii = {
  #   
  #   enable = true;
  #   enableNginx = true;
  #   virtualHost = "0.0.0.0";
  #   settings = {
  #     APP_ENV = "production"; 
  #     APP_KEY_FILE = config.sops.secrets.firefly-key.path;
  #     DB_CONNECTION = "pgsql";
  #     DB_HOST = "localhost";
  #     DB_PORT = 5432;
  #     DB_DATABASE = "firefly";
  #     DB_USERNAME = "firefly";
  #     DB_PASSWORD_FILE = config.sops.secrets.firefly-db-password.path;
  #   };
  # };

  # Configure PostgreSQL Container
  virtualisation.docker.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      firefly_iii_core = {
        image = "fireflyiii/core:latest";
        autoStart = true;
        restartPolicy = "always";
        ports = ["80:8080"];
        hostname = "firefly-iii";
        volumes = [
            (config.sops.secrets.firefly-key.path + ":/run/secrets/firefly-key:ro")
            (config.sops.secrets.firefly-db-password.path + ":/run/secrets/firefly-db-password:ro")
            "/var/lib/firefly-iii/storage:/var/www/html/storage"
        ];
        environment = {
          APP_ENV = "production"; 
          APP_URL = "http://localhost:8080";
          APP_KEY_FILE = config.sops.secrets.firefly-key.path;
          DB_CONNECTION = "pgsql";
          DB_HOST = "firefly-db";
          DB_PORT = 5432;
          DB_DATABASE = "firefly";
          DB_USERNAME = "firefly";
          DB_PASSWORD_FILE = config.sops.secrets.firefly-db-password.path;
          TZ = "America/Sao_Paulo";
        };
        dependsOn = [ "firefly_iii_db" ];
      };
      firefly_iii_db = {
        image = "postgres:latest";
        autoStart = true;
        hostname = "firefly-db";
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
  };
}

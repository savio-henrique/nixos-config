{config}:
{
  firefly_iii_db = {
    image = "postgres:latest";
    autoStart = true;
    hostname = "firefly-db";
    volumes = [
        (config.sops.secrets.firefly-db-password.path +":"+config.sops.secrets.firefly-db-password.path+":ro")
        "/var/lib/postgresql/data:/var/lib/postgresql/data"
    ];
    environment = {
      POSTGRES_USER = "firefly";
      POSTGRES_PASSWORD_FILE = config.sops.secrets.firefly-db-password.path;
      POSTGRES_DB = "firefly";
    };
  };
}

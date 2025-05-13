{config,port}:
{
  firefly_iii_core = {
    image = "fireflyiii/core:latest";
    autoStart = true;
    ports = [(port + ":8080")];
    hostname = "firefly-iii";
    user = "www-data:www-data";
    volumes = [
        "firefly_iii_upload:/var/www/html/storage/upload"
    ];
    environment = {
      APP_ENV = "production"; 
      APP_URL = ("http://localhost:"+port);
      DB_CONNECTION = "pgsql";
      DB_HOST = "172.17.0.2";
      DB_PORT = "5432";
      DB_DATABASE = "firefly";
      DB_USERNAME = "firefly";
      TZ = "America/Sao_Paulo";
      DEFAULT_LANGUAGE = "pt_BR";
    };
    environmentFiles = [
      config.sops.secrets.firefly-db-env.path
      config.sops.secrets.firefly-key.path
    ];
    dependsOn = [ "firefly_iii_db" ];
  };
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

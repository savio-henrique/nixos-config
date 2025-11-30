{config,port,network}:
{
  firefly_iii_core = let url= ("http://firefly.homelab:"+port); in {
    image = "fireflyiii/core:latest";
    autoStart = true;
    ports = [(port + ":8080")];
    hostname = "firefly_iii_core";
    user = "www-data:www-data";
    volumes = [
        "firefly_iii_upload:/var/www/html/storage/upload"
    ];
    labels = {
      "homepage.group" = "Personal";
      "homepage.name" = "Firefly";
      "homepage.icon" = "https://www.firefly-iii.org/assets/favicon/favicon.ico";
      "homepage.href" = url;
      "homepage.description" = "Personal Finance Manager.";
      "homepage.widget.type"= "firefly";
      "homepage.widget.url"= "http://firefly_iii_core:8080";
      "homepage.widget.key"= "{{HOMEPAGE_FILE_FIREFLY_KEY}}";
    };
    environment = {
      APP_ENV = "production"; 
      APP_URL = url;
      DB_CONNECTION = "pgsql";
      DB_HOST = "firefly_iii_db";
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
    extraOptions = [
      "--network=${network}"
    ];
  };
  firefly_iii_db = {
    image = "postgres:latest";
    autoStart = true;
    hostname = "firefly_iii_db";
    volumes = [
        (config.sops.secrets.firefly-db-password.path +":"+config.sops.secrets.firefly-db-password.path+":ro")
        "firefly_postgres:/var/lib/postgresql/18/docker"
    ];
    environment = {
      POSTGRES_USER = "firefly";
      POSTGRES_PASSWORD_FILE = config.sops.secrets.firefly-db-password.path;
      POSTGRES_DB = "firefly";
    };
    extraOptions = [
      "--network=${network}"
    ];
  };
}

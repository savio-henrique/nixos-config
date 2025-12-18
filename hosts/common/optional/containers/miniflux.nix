{config,port,network}:
{
  miniflux = let 
    url= ("http://miniflux.homelab:"+port); 
  in {
    image = "miniflux/miniflux:latest";
    autoStart = true;
    ports = [(port +":8080")];
    hostname = "miniflux";
    labels = {
      "homepage.group" = "Personal";
      "homepage.name" = "Miniflux";
      "homepage.icon" = "https://raw.githubusercontent.com/miniflux/logo/refs/heads/master/icon.svg";
      "homepage.href" = url;
      "homepage.description" = "Minimalist and opinionated feed reader.";
    };
    environmentFiles = [
      config.sops.secrets.miniflux-admin-username.path
      config.sops.secrets.miniflux-admin-password.path
      config.sops.secrets.miniflux-db-url.path
    ];
    environment = {
      RUN_MIGRATIONS = "1";
      CREATE_ADMIN = "1";
    };
    extraOptions = [
      "--network=${network}"
    ];
    dependsOn = [ "miniflux_db" ];
  };
  miniflux_db = {
    image = "postgres:18";
    autoStart = true;
    hostname = "miniflux_db";
    volumes = [
        "miniflux_postgres:/var/lib/postgresql"
    ];
    environment = {
      POSTGRES_DB = "miniflux";
    };
    environmentFiles = [
      config.sops.secrets.miniflux-db-user.path
      config.sops.secrets.miniflux-db-password.path
    ];
    extraOptions = [
      "--network=${network}"
    ];
  };
}

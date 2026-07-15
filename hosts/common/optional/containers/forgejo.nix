{config,port,dir,network}:
{
  forgejo = let
    url= ("http://forgejo.homelab:"+port); 
  in {
    image = "codeberg.org/forgejo/forgejo:15-rootless";
    autoStart = true;
    user = "1000:1000";
    ports = [(port +":3000") "2222:2222"];
    hostname = "forgejo";
    labels = {
      "homepage.group" = "Infrastructure";
      "homepage.name" = "Forgejo";
      "homepage.icon" = "https://forgejo.org/images/forgejo-wordmark.svg";
      "homepage.href" = url;
      "homepage.description" = "Selfhosted Git Repository Management.";
    };
    volumes = [
      "${dir}/data:/var/lib/gitea"
      "/etc/localtime:/etc/localtime:ro"
    ];
    environment = {
      USER_UID = "1000";
      USER_GID = "1000";
      FORGEJO__database__DB_TYPE = "postgres";
      FORGEJO__database__HOST = "forgejo_db:5432";
      FORGEJO__database__NAME = "forgejo";
      FORGEJO__database__USER = "forgejo_user";
    };
    environmentFiles = [
      config.sops.secrets.forgejo-password.path
    ];
    dependsOn = [ "forgejo_db" ];
    extraOptions = [
      "--network=${network}"
    ];
  };
  forgejo_db = {
    image = "postgres:14-alpine";
    autoStart = true;
    hostname = "forgejo_db";
    volumes = [
        "${dir}/postgres:/var/lib/postgresql/data"
    ];
    environment = {
      POSTGRES_DB = "forgejo";
      POSTGRES_USER = "forgejo_user";
    };
    environmentFiles = [
      config.sops.secrets.forgejo-db-password.path
    ];
    extraOptions = [
      "--network=${network}"
    ];
  };
}

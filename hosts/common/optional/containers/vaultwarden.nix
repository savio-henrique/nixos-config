{config, port, dir, network}:
{
  vaultwarden = let url = ("http://vault.homelab:"+port); in {
    image = "vaultwarden/server:latest-alpine";
    autoStart = true;
    ports = [ (port + ":80") ];
    hostname = "vaultwarden";
    environment = {
      SIGNUPS_ALLOWED = "true";
    }; 
    volumes = [
      "${dir}/vw-data:/data"
      (config.sops.secrets.vaultwarden-env.path + ":" + config.sops.secrets.vaultwarden-env.path + ":ro")
    ];
    environmentFiles = [
      config.sops.secrets.vaultwarden-env.path
    ];
    labels = {
      "homepage.group" = "Personal";
      "homepage.name" = "Vaultwarden";
      "homepage.icon" = "https://raw.githubusercontent.com/dani-garcia/vaultwarden/refs/heads/main/resources/vaultwarden-icon.svg";
      "homepage.href" = url;
      "homepage.description" = "Self-hosted password manager.";
    };
    dependsOn = [ "vaultwarden_db" ];
    extraOptions = [
      "--network=${network}"
    ];
  };
  vaultwarden_db = {
    image = "postgres:latest";
    autoStart = true;
    hostname = "vaultwarden_db";
    volumes = [
      "${dir}/vw-db:/var/lib/postgresql/data"
      (config.sops.secrets.vaultwarden-db-password.path + ":" + config.sops.secrets.vaultwarden-db-password.path + ":ro")
    ];
    environment = {
      POSTGRES_USER = "vaultwarden";
      POSTGRES_PASSWORD_FILE = config.sops.secrets.vaultwarden-db-password.path;
      POSTGRES_DB = "vaultwarden";
    };
    extraOptions = [
      "--network=${network}"
    ];
  };
}

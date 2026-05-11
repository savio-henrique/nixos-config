{config,port,network}:
{
  kaneo_core = let
    url= ("http://kaneo.homelab:"+port); 
  in {
    image = "ghcr.io/usekaneo/kaneo:2.7.2";
    autoStart = true;
    ports = [(port +":5173")];
    hostname = "kaneo_core";
    labels = {
      "homepage.group" = "Personal";
      "homepage.name" = "Kaneo";
      "homepage.icon" = "https://camo.githubusercontent.com/df73909d5a5fa1b08d455d0ea938a5c3ab1474a9f06ecba59ed6427b23fb1860/68747470733a2f2f6173736574732e6b616e656f2e6170702f6c6f676f2d6d6f6e6f2d726f756e6465642e706e67";
      "homepage.href" = url;
      "homepage.description" = "Selfhosted Project Management.";
    };
    environmentFiles = [
      config.sops.secrets.kaneo-client-url.path
      config.sops.secrets.kaneo-jwt.path
      config.sops.secrets.kaneo-db-url.path
      config.sops.secrets.kaneo-github-client-id.path
      config.sops.secrets.kaneo-github-client-secret.path
      config.sops.secrets.kaneo-github-app-id.path
      config.sops.secrets.kaneo-github-webhook-secret.path
      config.sops.secrets.kaneo-github-private-key.path
      config.sops.secrets.kaneo-github-app-name.path
      config.sops.secrets.kaneo-smtp-host.path
      config.sops.secrets.kaneo-smtp-port.path
      config.sops.secrets.kaneo-smtp-secure.path
      config.sops.secrets.kaneo-smtp-user.path
      config.sops.secrets.kaneo-smtp-from-email.path
      config.sops.secrets.kaneo-smtp-password.path
      config.sops.secrets.kaneo-smtp-require-tls.path
    ];
    environment = {
      DISABLE_GUEST_ACCESS = "true";
      DISABLE_REGISTRATION = "false";
    };
    dependsOn = [ "kaneo_db" ];
    extraOptions = [
      "--network=${network}"
    ];
  };
  kaneo_db = {
    image = "postgres:16-alpine";
    autoStart = true;
    hostname = "kaneo_db";
    volumes = [
        "kaneo_data:/var/lib/postgresql/data"
    ];
    environment = {
      POSTGRES_DB = "kaneo";
      POSTGRES_USER = "kaneo_user";
    };
    environmentFiles = [
      config.sops.secrets.kaneo-db-password.path
    ];
    extraOptions = [
      "--network=${network}"
    ];
  };
}

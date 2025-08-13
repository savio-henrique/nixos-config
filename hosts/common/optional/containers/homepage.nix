{config, dir, network}:
{
  homepage = {
    image = "ghcr.io/gethomepage/homepage:latest";
    hostname = "homepage";
    autoStart = true;
    ports = ["3000:3000"];
    volumes = [
      (dir + ":/app/config")
      (config.sops.secrets.firefly-api-key.path +":"+config.sops.secrets.firefly-api-key.path+":ro" )
      (config.sops.secrets.trilium-etapi-token.path + ":" + config.sops.secrets.trilium-etapi-token.path + ":ro")
      "/var/run/docker.sock:/var/run/docker.sock"
    ];
    environment = {
      HOMEPAGE_ALLOWED_HOSTS = "*";
      HOMEPAGE_FILE_FIREFLY_KEY = config.sops.secrets.firefly-api-key.path;
      HOMEPAGE_FILE_TRILIUM_ETAPI_TOKEN = config.sops.secrets.trilium-etapi-token.path;
    };
    extraOptions = [
      "--network=${network}"
    ];
  };
}

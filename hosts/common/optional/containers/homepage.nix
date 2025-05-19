{config, dir}:
{
  homepage = {
    image = "ghcr.io/gethomepage/homepage:latest";
    hostname = "homepage";
    autoStart = true;
    ports = ["3000:3000"];
    volumes = [
      (dir + ":/app/config")
      (config.sops.secrets.firefly-api-key.path +":"+config.sops.secrets.firefly-api-key.path+":ro" )
      "/var/run/docker.sock:/var/run/docker.sock"
    ];
    environment = {
      HOMEPAGE_ALLOWED_HOSTS = "*";
      HOMEPAGE_FILE_FIREFLY_KEY = config.sops.secrets.firefly-api-key.path;
    };
  };
}

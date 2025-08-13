{config, port, dir, network}:
{
  trilium_server = let url = ("http://trilium.homelab:"+port); in {
    image = "triliumnext/trilium:stable";
    autoStart = true;
    ports = [(port + ":8080")];
    hostname = "trilium_server";
    volumes = [
        (dir + ":/home/node/trilium-data")
        "/etc/timezone:/etc/timezone:ro"
        "/etc/localtime:/etc/localtime:ro"
    ];
    labels = {
      "homepage.group" = "Personal";
      "homepage.name" = "Trilium";
      "homepage.icon" = "https://avatars.githubusercontent.com/u/160046342?s=200&v=4";
      "homepage.href" = url;
      "homepage.description" = "Personal Note-taking app.";
      "homepage.widget.type" = "trilium";
      "homepage.widget.url" = "http://trilium_server:8080";
      "homepage.widget.key" = "{{HOMEPAGE_FILE_TRILIUM_ETAPI_TOKEN}}";
    };
    environment = {
      TRILIUM_DATA_DIR = "/home/node/trilium-data";
    };
    extraOptions = [
      "--network=${network}"
    ];
  };
}

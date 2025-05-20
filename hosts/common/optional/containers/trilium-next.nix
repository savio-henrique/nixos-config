{config, port, dir, network}:
{
  trilium_server = {
    image = "triliumnext/notes:v0.93.0";
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
      "homepage.href" = "trilium_server:${port}";
      "homepage.description" = "Personal Note-taking app.";
    };
    environment = {
      TRILIUM_DATA_DIR = "/home/node/trilium-data";
    };
    extraOptions = [
      "--network=${network}"
    ];
  };
}

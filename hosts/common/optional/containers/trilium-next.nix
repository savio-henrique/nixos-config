{config,port,dir}:
{
  trilium_server = {
    image = "triliumnext/notes:v0.93.0";
    autoStart = true;
    ports = [(port + ":8080")];
    hostname = "trilium-server";
    volumes = [
        (dir + ":/home/node/trilium-data")
        "/etc/timezone:/etc/timezone:ro"
        "/etc/localtime:/etc/localtime:ro"
    ];
    environment = {
      TRILIUM_DATA_DIR = dir;
    };
  };
}

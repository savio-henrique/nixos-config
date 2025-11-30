{config,port, network}: {
  minecraft_server = {
    image = "itzg/minecraft-server:latest";
    autoStart = true;
    hostname = "minecraft_server";
    ports = [
      "25565:25565"
    ];
    volumes = [
      "minecraft_data:/data"
    ];
    environment = {
      EULA = "TRUE";
      MEMORY = "4096M";
      USE_AIKAR_FLAGS = "TRUE";
      USE_MEOWICE_FLAGS = "TRUE";
      MODRINTH_PROJECTS = "chunky\nfabric-api\nferrite-core\nlithium\nkrypton";
      TZ = "America/Sao_Paulo";
      TYPE = "FABRIC";
      DIFFICULTY = "3";
    };
    extraOptions = [
      "--network=${network}"
    ];
  };
}

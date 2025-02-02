{pkgs, config, lib, ...}:
{
  services.minecraft-server = {
    enable = true;
    eula = true;
    declarative = true;
    openFirewall = true;

    dataDir = "/var/lib/minecraft-server";
    serverProperties = {
      gamemode = "survival";
      difficulty = "hard";
      simulation-distance = 10;
      max-players = 10;
      modt = "My NixOS test server!";
      white-list = true;
      allow-cheats = true;
    };

    whitelist = {
      "Hakyoku228" = "6b9e88e5-21eb-4f7e-a684-74a0185f8e49";
    };

    jvmOpts = "-Xms1G -Xmx8G";
  };
}

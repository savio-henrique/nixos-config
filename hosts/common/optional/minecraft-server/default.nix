{pkgs, config, lib, inputs, ...}:
let
  modpack = pkgs.fetchPackwizModpack {
    url = "https://raw.githubusercontent.com/savio-henrique/FastPack/refs/heads/main/v1/pack.toml";
    packHash = "sha256-1+ZNi7Uz5mRJ9p56DKfjxUqoLzXp0RJD5WeBUkQU5s4=";
    manifestHash = "a03831d9f7f9317df08319f0c218ef585d5323198bd61ed78ec3e25335965bc6";
  };
in {
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    dataDir = "/var/lib/minecraft/servers";
    user = "minecraft";
    group = "minecraft";

    servers.nixos-server = {
      enable = true;
      autoStart = false;
      enableReload = true;
      package = pkgs.fabricServers.fabric-1_21_8;
      serverProperties = {
        openFirewall = true;
        server-port = 25565;
        gamemode = "survival";
        difficulty = "hard";
        max-players = 10;
        online-mode = true;
        modt = "My NixOS test server!";
        white-list = true;
        allow-cheats = true;
        enforce-secure-profile = false;
        enforce-whitelist = true;
        allow-flight = true;
      };
      operators = {
        "Hakyoku228" = "6b9e88e5-21eb-4f7e-a684-74a0185f8e49";
      };
      symlinks = {
        "mods" = "${modpack}/mods";
      };
      whitelist = {
        "Hakyoku228" = "6b9e88e5-21eb-4f7e-a684-74a0185f8e49";
      };
      jvmOpts = "-Xms1G -Xmx8G -XX:+UseParallelGC";

    };
  };
}

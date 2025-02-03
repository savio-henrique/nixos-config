{pkgs, config, lib, inputs, ...}:
{
  services.minecraft-servers = {
    enable = true;
    eula = true;
    dataDir = "/var/lib/minecraft-server";
    openFirewall = true;

    servers = {
      nixos-server = {
        enable = false;
        package = pkgs.vanillaServers.vanilla-1_21_4;
        serverProperties = {
          openFirewall = true;
          server-port = 25565;
          gamemode = "survival";
          difficulty = "hard";
          max-players = 10;
          modt = "My NixOS test server!";
          white-list = true;
          allow-cheats = true;
          enforce-secure-profile = false;
          enforce-whitelist = true;
        };
        whitelist = {
          "Hakyoku228" = "6b9e88e5-21eb-4f7e-a684-74a0185f8e49";
        };
        jvmOpts = "-Xmx6G -Xms6G -XX:+UseG1GC -Dsun.rmi.dgc.server.gcInterval=2147483646 -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M";
      };
      fast-server = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_21_4;
        serverProperties = {
          openFirewall = true;
          server-port = 25565;
          gamemode = "survival";
          difficulty = "hard";
          max-players = 10;
          modt = "My NixOS test server!";
          white-list = true;
          allow-cheats = true;
          enforce-secure-profile = false;
          enforce-whitelist = true;
        };
        whitelist = {
          "Hakyoku228" = "6b9e88e5-21eb-4f7e-a684-74a0185f8e49";
        };

        symlinks = {
          "mods" = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
            Lithium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/QCuodIia/lithium-fabric-0.14.7%2Bmc1.21.4.jar";
              sha256 = "25d61fc3f77f798f930674e8cbac68f2a031864a4bced7d56dc7b73f525e9465";
            };
            FerriteCore = pkgs.fetchurl { 
              url = "https://cdn.modrinth.com/data/uXXizFIs/versions/IPM0JlHd/ferritecore-7.1.1-fabric.jar"; 
              sha256 = "0dd5e9203552024e38e73a0f5b46a82eb66f0318b23289c6842b268663274a79";
            };
            Krypton = pkgs.fetchurl { 
              url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/Acz3ttTp/krypton-0.2.8.jar"; 
              sha256 = "94f195819b24e5da64effdc9da15cdd84836cc75e8ff0fd098bab6bc2f49e3fe";
            };
            Noisium = pkgs.fetchurl { 
              url = "https://cdn.modrinth.com/data/KuNKN7d2/versions/9NHdQfkN/noisium-fabric-2.5.0%2Bmc1.21.4.jar"; 
              sha256 = "26649b7c5dc80da0b50627d1f1668a142a5a9ba9c7941590cd5af20d1e96beda";
            };
            C2ME = pkgs.fetchurl { 
              url = "https://cdn.modrinth.com/data/VSNURh3q/versions/yGX4O0YU/c2me-fabric-mc1.21.4-0.3.1.1.0.jar"; 
              sha256 = "79e28e28957228c21b775dbfbd122d58d325b82c2ceffdd38a41a65307dddbf0";
            };
          }); 
        };

        jvmOpts = "-Xmx6G -Xms6G -XX:+UseG1GC -Dsun.rmi.dgc.server.gcInterval=2147483646 -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M";
      };
    };
  };
}

{config,port,network, dir}:
{
  copyparty = let 
    url= ("http://copyparty.homelab:"+port); 
    copypartyConfig = (builtins.readFile ./copyparty.conf);
    configDir = builtins.toFile "copyparty.conf" copypartyConfig;
  in {
    image = "ghcr.io/9001/copyparty-ac";
    autoStart = true;
    ports = [(port +":3923")];
    hostname = "copyparty";
    labels = {
      "homepage.group" = "Personal";
      "homepage.name" = "Copyparty";
      "homepage.icon" = "https://raw.githubusercontent.com/9001/copyparty/hovudstraum/docs/logo.svg";
      "homepage.href" = url;
      "homepage.description" = "Selfhosted File Server.";
    };
    volumes = [
      (configDir + ":/cfg/copyparty.conf:z")
      (dir + ":/w:z")
      (config.sops.secrets.copyparty-user.path + ":/etc/copyparty/users:ro,z")
    ];
    environment = {
      LD_PRELOAD = "/usr/lib/libmimalloc-secure.so.2";
    };
    extraOptions = [
      "--network=${network}"
    ];
  };
}

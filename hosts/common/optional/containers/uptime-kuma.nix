{config,port,network}:
{
  uptime_kuma = let 
    url= ("http://uptime-kuma.homelab:"+port); 
  in {
    image = "louislam/uptime-kuma:2";
    autoStart = true;
    ports = [(port +":3001")];
    hostname = "uptime_kuma";
    labels = {
      "homepage.group" = "Infrastructure";
      "homepage.name" = "Uptime Kuma";
      "homepage.icon" = "https://raw.githubusercontent.com/louislam/uptime-kuma/refs/heads/master/public/icon.svg";
      "homepage.href" = url;
      "homepage.description" = "Self-hosted monitoring tool.";
    };
    environmentFiles = [
      config.sops.secrets.uptime-kuma-cloudflared-token.path
    ];
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
       "uptime_kuma_data:/app/data:rw"
    ];
    extraOptions = [
      "--network=${network}"
    ];
  };
}

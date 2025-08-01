{config,network}:
{
  cloudflared = {
    image = " cloudflare/cloudflared:latest";
    autoStart = true;
    ports = [("7844" + ":7844")];
    hostname = "cloudflared";
    labels = {
      "homepage.group" = "Infra";
      "homepage.name" = "Cloudflared";
      "homepage.icon" = "https://cf-assets.www.cloudflare.com/slt3lc6tev37/fdh7MDcUlyADCr49kuUs2/5f780ced9677a05d52b05605be88bc6f/cf-logo-v-rgb.png";
      "homepage.description" = "Cloudflare Tunnel";
    };
    volumes = [
      (config.sops.secrets.cloudflare-token.path + ":" + config.sops.secrets.cloudflare-token.path + ":ro")
    ];
    cmd = ["tunnel" "--no-autoupdate" "run" "--token-file" config.sops.secrets.cloudflare-token.path ];
    extraOptions = [
      "--network=${network}"
    ];
  };
}

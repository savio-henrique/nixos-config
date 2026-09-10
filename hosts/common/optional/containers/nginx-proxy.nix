{network}:
{
  nginx_proxy_manager = let
    url= ("http://nginx.home.shxnix.dev"); 
  in {
    image = "jc21/nginx-proxy-manager:2.15.1";
    autoStart = true;
    ports = ["80:80" "81:81" "443:443"];
    hostname = "nginx_proxy_manager";
    labels = {
      "homepage.group" = "Infrastructure";
      "homepage.name" = "Nginx Proxy Manager";
      "homepage.icon" = "https://nginxproxymanager.com/logo.svg";
      "homepage.href" = url;
      "homepage.description" = "Selfhosted Reverse Proxy Manager.";
    };
    volumes = [
      "nginx_proxy_manager_data:/data"
      "nginx_proxy_manager_letsencrypt:/etc/letsencrypt"
    ];
    environment = {
      TZ = "America/Sao_Paulo";
    };
    extraOptions = [
      "--network=${network}"
    ];
  };
}

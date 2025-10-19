{config,port,network}:
{
  kaneo_nginx = let 
    url= ("http://kaneo.homelab:"+port); 
    nginxConfig = ''
      server {
        listen 80;
        server_name localhost;
       
        location / {
          proxy_pass http://kaneo_frontend:5173;
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }
       
        location /api/ {
          proxy_pass http://kaneo_backend:1337/;
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }
      }
    '';
    configDir = builtins.toFile "kaneo.conf" nginxConfig;
  in {
    image = "nginx:1.29.2-alpine";
    autoStart = true;
    ports = [(port +":80")];
    hostname = "kaneo_nginx";
    labels = {
      "homepage.group" = "Personal";
      "homepage.name" = "Kaneo";
      "homepage.icon" = "https://camo.githubusercontent.com/df73909d5a5fa1b08d455d0ea938a5c3ab1474a9f06ecba59ed6427b23fb1860/68747470733a2f2f6173736574732e6b616e656f2e6170702f6c6f676f2d6d6f6e6f2d726f756e6465642e706e67";
      "homepage.href" = url;
      "homepage.description" = "Selfhosted Project Management.";
    };
    volumes = [
        (configDir + ":/etc/nginx/conf.d/default.conf:ro")
    ];
    dependsOn = [ 
      "kaneo_frontend"
      "kaneo_backend"
    ];
    extraOptions = [
      "--network=${network}"
    ];
  };
  kaneo_frontend = {
    image = "ghcr.io/usekaneo/web:latest";
    autoStart = true;
    hostname = "kaneo_frontend";
    environment = {
      KANEO_API_URL = "/api";
    };
    dependsOn = [ "kaneo_backend" ];
    extraOptions = [
      "--network=${network}"
    ];
  };
  kaneo_backend = {
    image = "ghcr.io/usekaneo/api:latest";
    autoStart = true;
    hostname = "kaneo_backend";
    environmentFiles = [
      config.sops.secrets.kaneo-jwt.path
      config.sops.secrets.kaneo-db-url.path
    ];
    dependsOn = [ "kaneo_db" ];
    extraOptions = [
      "--network=${network}"
    ];
  };
  kaneo_db = {
    image = "postgres:16-alpine";
    autoStart = true;
    hostname = "kaneo_db";
    volumes = [
        "kaneo_data:/var/lib/postgresql/data"
    ];
    environment = {
      POSTGRES_DB = "kaneo";
      POSTGRES_USER = "kaneo_user";
    };
    environmentFiles = [
      config.sops.secrets.kaneo-db-password.path
    ];
    extraOptions = [
      "--network=${network}"
    ];
  };
}

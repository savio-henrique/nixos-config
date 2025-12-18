{inputs, config, ...}:
{
  imports = [
    ../common/global
    ../common/optional/containers 
    # ../common/optional/minecraft-server
    # inputs.nix-minecraft.nixosModules.minecraft-servers
    ./configuration.nix
  ];


  # Configure Minecraft Overlay
  # nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  # Configure SOPS
  sops.secrets = {

    # Firefly Secrets
    firefly-key = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    firefly-db-password= {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    firefly-db-env= {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    firefly-api-key = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };

    # PiHole Secrets
    pihole-api-key = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    pihole-password-env = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    pihole-password = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    unbound-config = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };

    # Vaultwarden Secrets
    vaultwarden-db-password = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    vaultwarden-env = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };

    # Cloudflare Tunnel
    cloudflare-token = {
      sopsFile = ../common/secrets.yaml;
      path = "/usr/share/cloudflared/cloudflare-token";
      mode = "0444";
    };

    # Trilium Secrets
    trilium-etapi-token = {
      sopsFile = ../common/secrets.yaml;
      mode = "0444";
    };

    # Kaneo Secrets
    kaneo-jwt = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    kaneo-db-url = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    kaneo-db-password = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    kaneo-github-client-id = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    kaneo-github-client-secret = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    kaneo-client-url = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    kaneo-api-url = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    kaneo-smtp-host = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    kaneo-smtp-port = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    kaneo-smtp-secure = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    kaneo-smtp-user = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    kaneo-smtp-password = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    kaneo-smtp-from-email = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };


    # Uptime Kuma Secrets
    uptime-kuma-cloudflared-token = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };

    # Miniflux Secrets
    miniflux-admin-username = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    miniflux-admin-password = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    miniflux-db-url = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    miniflux-db-user = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    miniflux-db-password = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
  };

  oci-config = {
    enable  = true;
    cloudflare = {
      enable = true;
    };
    firefly-iii = {
      enable = true;
      port = 8080;
    };
    trilium = {
      enable = true;
      port = 8081;
      dir = "/home/saviohc/trilium-data";
    };
    homepage = {
      enable = true;
      dir = "/home/saviohc/homepage-config";
    };
    uptime-kuma = {
      enable = true;
      port = 8083;
    };
    miniflux = {
      enable = true;
      port = 8082;
    };
    # vaultwarden = {
    #   enable = false;
    #   port = 8082;
    #   dir = "/home/saviohc/vaultwarden/";
    # };
    # prometheus = {
    #   enable = true;
    #   port = 9090;
    # };
    # grafana = {
    #   enable = true;
    #   port = 9000;
    # };
    kaneo = {
      enable = true;
      port = 3030;
    };
    minecraft = {
      enable = false;
      port = 25565;
    };
  };

  services.tailscale.enable = true;
}

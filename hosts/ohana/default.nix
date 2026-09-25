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
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    firefly-db-password= {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    firefly-db-env= {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    firefly-api-key = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };

    # Vaultwarden Secrets
    vaultwarden-db-password = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    vaultwarden-env = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };

    # Cloudflare Tunnel
    cloudflare-token = {
      sopsFile = ./secrets.yaml;
      path = "/usr/share/cloudflared/cloudflare-token";
      mode = "0444";
    };

    # Trilium Secrets
    trilium-etapi-token = {
      sopsFile = ./secrets.yaml;
      mode = "0444";
    };

    # Kaneo Secrets
    kaneo-jwt = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    kaneo-db-url = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    kaneo-db-password = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    kaneo-github-client-id = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    kaneo-github-client-secret = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    kaneo-github-app-id = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    kaneo-github-webhook-secret = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    kaneo-github-private-key = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    kaneo-github-app-name = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    kaneo-client-url = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    kaneo-smtp-host = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    kaneo-smtp-port = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    kaneo-smtp-secure = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    kaneo-smtp-user = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    kaneo-smtp-password = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    kaneo-smtp-from-email = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    kaneo-smtp-require-tls = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };

    # Uptime Kuma Secrets
    uptime-kuma-cloudflared-token = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };

    # Miniflux Secrets
    miniflux-admin-username = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    miniflux-admin-password = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    miniflux-db-url = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    miniflux-db-user = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    miniflux-db-password = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };

    # Copyparty Secrets
    copyparty-user = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    copyparty-group = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };

    # Forgejo Secrets
    forgejo-db-password = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
    forgejo-password = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
  };

  oci-config = {
    enable  = true;
    nginx-proxy = {
      enable = true;
    };
    cloudflare = {
      enable = true;
    };
    firefly-iii = {
      enable = false;
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
    copyparty = {
      enable = true;
      port = 7654;
      dir = "/home/saviohc/copyparty-data";
    };
    vaultwarden = {
      enable = true;
      port = 8085;
      dir = "/home/saviohc/vaultwarden/";
    };
    # prometheus = {
    #   enable = true;
    #   port = 9090;
    # };
    # grafana = {
    #   enable = true;
    #   port = 9000;
    # };
    kaneo = {
      enable = false;
      port = 3030;
    };
    minecraft = {
      enable = false;
      port = 25565;
    };
    forgejo = {
      enable = true;
      port = 3032;
      dir = "/home/saviohc/forgejo-data";
    };
    actual = {
      enable = true;
      port = 5006;
      dir = "/home/saviohc/actual-budget-data";
    };
  };

  services.tailscale.enable = true;
}

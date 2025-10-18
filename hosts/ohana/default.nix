{inputs, config, ...}:
{
  imports = [
    ../common/global
    ../common/optional/containers 
    ../common/optional/minecraft-server
    ./configuration.nix
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];


  # Configure Minecraft Overlay
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  # Configure SOPS
  sops.secrets = {
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
    vaultwarden-db-password = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    vaultwarden-env = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    cloudflare-token = {
      sopsFile = ../common/secrets.yaml;
      path = "/usr/share/cloudflared/cloudflare-token";
      mode = "0444";
    };
    trilium-etapi-token = {
      sopsFile = ../common/secrets.yaml;
      mode = "0444";
    };
  };

  oci-config = {
    enable  = true;
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
    vaultwarden = {
      enable = false;
      port = 8082;
      dir = "/home/saviohc/vaultwarden/";
    };
    prometheus = {
      enable = true;
      port = 9090;
    };
    grafana = {
      enable = true;
      port = 9000;
    };
  };

  services.tailscale.enable = true;
}

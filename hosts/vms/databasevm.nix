{inputs, pkgs, config, ...}:
{
  imports = [
    ../common/global/openssh.nix
    ../common/global/sops.nix
    ../common/users/developer.nix
    ./configuration.nix
  ];

  # Configure SOPS
  sops.secrets = {
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
    kaneo-github-app-id = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    kaneo-github-webhook-secret = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    kaneo-github-private-key = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    kaneo-github-app-name = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
    kaneo-client-url = {
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
    kaneo-smtp-require-tls = {
      sopsFile = ../common/secrets.yaml;
      group = "www-data";
    };
  };

  systemd.tmpfiles.settings = {
    "postgres-data" = {
      "/var/lib/postgresql/16/data" = {d.mode = "0700"; d.user = "postgres"; d.group = "postgres";}; 
    };
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
    '';
    dataDir = "/var/lib/postgresql/16/data";
  };

}

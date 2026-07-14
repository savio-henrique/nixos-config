{
  config,
  ...
}: {
  # User Configuration
  users.users.developer = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.developer-password.path;
    description = "Developer Machine";
    extraGroups = [ 
      "networkmanager"
      "www-data"
      "incus-admin"
      "docker"
    ];

  };

  sops.secrets.developer-password = {
    sopsFile = ./secrets.yaml;
    owner = "developer";
    neededForUsers = true;
  };
}

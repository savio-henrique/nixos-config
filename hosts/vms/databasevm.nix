{inputs, pkgs, config, ...}:
{
  imports = [
    ../common/global/openssh.nix
    ../common/global/sops.nix
    ../common/users/developer.nix
    ../common/optional/containers
    ./configuration.nix
  ];

  # Configure SOPS
  sops.secrets = {
    secret-test = {
      sopsFile = ./secrets.yaml;
      group = "www-data";
    };
  };

  oci-config = {
    enable = true;
    engine = "docker";
    rootless = false;
    excalidraw = {
      enable = true;
      port = 3000;
    };
  };


}

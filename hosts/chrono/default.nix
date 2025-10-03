{
  imports = [
    ../common/global
    ../common/optional/video.nix
    ../common/optional/containers
    ./configuration.nix
  ];

  video.enable = true;
  video.dual = true;
  video.environment = "hyprland";

  oci-config = {
    enable = true;
    engine = "docker";
    rootless = false;
  };

  # VM test configuration
  # virtualisation.vmVariant = {
  #   virtualisation = {
  #     memorySize = 8192; # 8 GB
  #     cores = 2;
  #   };
  # };

  services.tailscale.enable = true;
}

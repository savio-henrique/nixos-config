{inputs, config, ...}:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops.defaultSopsFormat = "yaml";

  # TODO- change keyfile path
  sops.age.keyFile = "/home/saviohc/.config/sops/age/keys.txt";
}

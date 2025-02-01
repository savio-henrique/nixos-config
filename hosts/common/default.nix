# Common configuration for all hosts
{
  lib,
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./openssh.nix
    ./users
  ];

  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  time.timeZone = "America/Sao_Paulo";

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [
        "root"
        "saviohc"
      ]; # Set users that are allowed to use the flake command
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    optimise.automatic = true;
    registry =
      (lib.mapAttrs (_: flake: {inherit flake;}))
      ((lib.filterAttrs (_: lib.isType "flake")) inputs);
    nixPath = ["/etc/nix/path"];
  };
}


{
  config,
  pkgs,
  inputs,
  ...
}: {
  # User Configuration
  users.users.saviohc = {
    isNormalUser = true;
    initialHashedPassword = "$y$j9T$nhvjL36HtJMFx8OFgKGkk/$1RKnk2Mfx1EOCQI7QHyIa.a4qZ6eJ8AThvVjHYoGc78";
    description = "Sávio Henrique User";
    extraGroups = [ 
      "wheel"
      "networkmanager"
      "docker"
      "libvirtd"
      "kvm"
    ];
  };

  # User Public Key Configuration
  openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgPG2otzfFvKw5oaqX/Irw6wl4TGyvt+fgDoWdXLvEb4wWH3TdvdaS731Jdwjl+2m3Xo2HNIgYIIvC8w0T4sGvyNQqxAKcDv9Z2zSZGRThOU/+1zInLQcSLAFZmchzK9TDajqNmYXz09CBCgrdp6O0rNPz5zRd3DMWeWrOY4DZFAq9ESgxQb6+n7MF2RDQMzbGqj1y/OFl5T28BI13bagZUlENXaXb25bkO/lK6GnXTkBARMeboxzVUNiRO84aikQMXHV91TfG7JyIoISUDgXYDv+sGAfdvJu1xJJm1IeSSp98vt05PH6BxUnNPyEbcn+bY7/9vYE7v7Eu0NoidLPoCinjAHCsd8ufMISgA1yrBoB3SlGTDE+qpF9T0fpEN6YBb4IqpVdbqUnV9AgKrIpvj8DYGJPEfHKNmLO+9i/dyccQ5+XlkWPKy1ULynufDO81rTGZvQZaBJIEq7D6d/+XbA7HDpsoH47RPXqQKvIAk8AVbIInfTsbcqaW2kS6tmk= saviohc@saviohc" 
  ];

  # Packages from Home-manager
  packages = [ inputs.home-manager.packages.${pkgs.system}.default ];

  # Home manager user
  home-manager.users.saviohc = import saviohc/${config.networking.hostName}.nix;
}

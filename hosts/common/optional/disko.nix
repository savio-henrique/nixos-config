{inputs, pkgs, config, lib, ...}:
{
  imports = [
    inputs.disko.nixosModules.disko
  ];

  disko.devices.nodev = {
    "/" = {
      fsType = "tmpfs";
      mountOptions = [ 
        "size=25%"
        "mode=775"
      ];
    };
  };

  disko.devices.disk.main = {
    device = "/dev/sda";
    type = "disk";

    content.type = "gpt";
    content.partitions.boot = {
      name = "boot";
      size = "1M";
      fsType = "EF02";
    };

    content.partitions.esp = {
      name = "ESP";
      size = "1G";
      fsType = "EF00";

      content = {
        type = "filesystem";
        format = "vfat";
        mountPoint = "/boot";
        mountOptions = [ "umask=0077" ];
      };
    };

    content.partitions.swap = {
      name = "swap";
      size = "8G";

      content = {
        type = "swap";
        resumeDevice = true;
      };
    };

    content.partitions.root = {
      name = "root";
      size = "100%";

      content = {
        type = "btrfs";
        extraArgs = ["-f"];


        subvolumes = {
          "/persistent" = {
            mountOptions = [ "subvol=persist" "noatime" ];
            mountPoint = "/persistent";
          };
          "/nix" = {
            mountOptions = [ "subvol=nix" "noatime" ];
            mountPoint = "/nix";
          };
        };
      };
    };
  };
}

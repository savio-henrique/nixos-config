{ lib, config, pkgs, ... }:

let
  cfg = config.main-user;
in
{
  options.main-user = {
    enable = lib.mkEnableOption "enable user module";

    userName = lib.mkOption {
      type = lib.types.str;
      default = "saviohc";
      description = ''
        username
      '';
    };

    name = lib.mkOption {
      type = lib.types.str;
      default = "Savio Henrique";
      description = ''
        name
      '';
    };

    groups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = ''
        groups
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      home = "/home/${cfg.userName}";
      initialPassword = "153426";
      description = "${cfg.name}";
      extraGroups = cfg.groups;
      shell = pkgs.fish;
      };
  };

}

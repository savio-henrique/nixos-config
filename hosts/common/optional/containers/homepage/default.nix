{lib, config, pkgs, inputs, ...}:
let
  homepage = config.homepage;
  
  # Default homepage configuration
  pageConf = import ./config/files.nix;
in {
  options.homepage = {
    enable = lib.mkOption {
      default = true;
      type = lib.types.bool;
      description = "Enable homepage";
    };
    config-dir = lib.mkOption {
      default = "/var/lib/homepage";
      type = lib.types.str;
      description = "Directory for homepage configuration";
    };
  };
  config = 
    let 
    config-script = 
      let
        homepageConfig = pageConf.homepageConfig;
      in pkgs.writeShellScriptBin "homepage-config" ''
        #!/usr/bin/env bash
        set -euo pipefail
        # Create the homepage config directory
        if [ ! -d "${homepage.config-dir}" ]; then
          mkdir -p "${homepage.config-dir}"
        fi

        echo "${homepageConfig.bookmarks}" > "${homepage.config-dir}/bookmarks.yaml"
        echo "${homepageConfig.services}" > "${homepage.config-dir}/services.yaml"
        echo "${homepageConfig.docker}" > "${homepage.config-dir}/docker.yaml"
        echo "${homepageConfig.settings}" > "${homepage.config-dir}/settings.yaml"
        echo "${homepageConfig.widgets}" > "${homepage.config-dir}/widgets.yaml"
    '';
    in lib.mkIf homepage.enable {
  
    # systemd service to create the homepage config directory
    systemd.services.homepage-config = {
      description = "Homepage Config";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        # Config Script 
        ExecStart = ''${config-script}/bin/homepage-config'';
      };
    };
  };
  
}

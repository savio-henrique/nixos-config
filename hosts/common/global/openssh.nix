{ outputs, lib, config, ... } :
let 
  hosts = lib.attrNames outputs.nixosConfigurations;
in {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      Port = 22;
      PermitEmptyPasswords = "no";
    };

  };

  programs.ssh = {
    startAgent = true;
  };
}

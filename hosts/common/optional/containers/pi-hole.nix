{config, network}:
{
  pi-hole = {
    image = "pihole/pihole:latest";
    autoStart = true;
    hostname = "pihole";
    ports = [
      "53:53/tcp"
      "53:53/udp"
      "80:80/tcp"
      "443:443/tcp"
    ];
    volumes = [
      "etc-pihole:/etc/pihole"
      "/var/log/pihole:/var/log/pihole"
    ];
    environment = {
      TZ = "America/Sao_Paulo";
      FTLCONF_dns_listeningMode = "all";
    };
    environmentFiles = [
      config.sops.secrets.pihole-password-env.path
    ];
    extraOptions = [
      "--network=${network}"
    ];
  };
  unbound = {
    image = "mvance/unbound:latest";
    autoStart = true;
    hostname = "unbound";
    ports = [
      "5335:53/tcp"
      "5335:53/udp"
    ];
    volumes = [
      (config.sops.secrets.unbound-config.path+":/opt/unbound/etc/unbound/unbound.conf")
      "/var/log/unbound:/var/log/unbound"
    ];
    extraOptions = [
      "--network=${network}"
    ];
  };

}

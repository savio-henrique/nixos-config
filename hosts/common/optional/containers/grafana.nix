{config, port, network}:
{
  grafana = let 
    url= ("http://grafana.homelab:"+port); 
  in {
    image = "grafana/grafana-enterprise";
    autoStart = true;
    ports = [(port + ":3000")];
    hostname = "grafana";
    volumes = [
      "grafana-storage:/var/lib/grafana"
    ];
    labels = {
      "homepage.group" = "Infrastructure";
      "homepage.name" = "Grafana";
      "homepage.icon" = "https://images.brilliantmade.com/uploads/attachment/file/79993/Logomark_Color.svg";
      "homepage.href" = url;
      "homepage.description" = "Monitoring and Data visualization suite.";
    };
    extraOptions = [
      "--network=${network}"
    ];
  };
}

{config, port, network}:
{
  prometheus = let 
    url= ("http://prometheus.homelab:"+port); 
    prometheusConfig = ''
      global:
        scrape_interval: 15s

        external_labels:
          monitor: 'codelab-monitor'

        scrape_failure_log_file: /prometheus/scrape-failures.log

      scrape_configs:
        - job_name: 'prometheus'
          scrape_interval: 5s
          static_configs:
            - targets: ['localhost:9090']

        - job_name: 'trilium'
          static_configs:
            - targets: ['trilium_server:8080']
          metrics_path: '/etapi/metrics'
          scrape_interval: 30s

          authorization:
            credentials_file: ${config.sops.secrets.trilium-etapi-token.path}
    '';
    configDir = builtins.toFile "prometheus.yml" prometheusConfig;
  in {
    image = "prom/prometheus:latest";
    autoStart = true;
    ports = [(port + ":9090")];
    hostname = "prometheus";
    volumes = [
        (configDir + ":/etc/prometheus/prometheus.yml")
      (config.sops.secrets.trilium-etapi-token.path + ":" + config.sops.secrets.trilium-etapi-token.path + ":ro")
      "prometheus-data:/prometheus"
        "/etc/timezone:/etc/timezone:ro"
        "/etc/localtime:/etc/localtime:ro"
    ];
    labels = {
      "homepage.group" = "Infrastructure";
      "homepage.name" = "Prometheus";
      "homepage.icon" = "https://prometheus.io/_next/static/media/prometheus-logo.7aa022e5.svg";
      "homepage.href" = url;
      "homepage.description" = "Monitoring and Alerting Toolkit.";
    };
    extraOptions = [
      "--network=${network}"
    ];
  };
}

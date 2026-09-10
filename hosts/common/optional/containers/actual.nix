{config,dir,port,network}:
{
  actual_budget = let url= ("http://actual.homelab:"+port); in {
    image = "ghcr.io/actualbudget/actual-server:26.8.0";
    autoStart = true;
    ports = [(port + ":5006")];
    hostname = "actual_budget";
    volumes = [
        "${dir}/data:/data"
    ];
    labels = {
      "homepage.group" = "Personal";
      "homepage.name" = "Actual Budget";
      "homepage.icon" = "https://avatars.githubusercontent.com/u/37879538?s=200&v=4";
      "homepage.href" = url;
      "homepage.description" = "Personal Finance Manager.";
    };
    extraOptions = [
      "--network=${network}"
    ];
  };
}

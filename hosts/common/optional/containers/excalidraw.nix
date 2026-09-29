{config, port,network}:
{
  excalidraw = let
    url= "https://excalidraw.tail.shxnix.dev";
  in {
    image = "excalidraw/excalidraw:latest";
    autoStart = true;
    ports = [(port +":80")];
    hostname = "excalidraw";
    labels = {
      "homepage.group" = "Personal";
      "homepage.name" = "Excalidraw";
      "homepage.icon" = "https://docs.excalidraw.com/img/logo.svg";
      "homepage.href" = url;
      "homepage.description" = "Selfhosted Excalidraw Instance";
    };
    environmentFiles = [
      config.sops.secrets.secret-test.path
    ];
    extraOptions = [
      "--network=${network}"
    ];
  };
}

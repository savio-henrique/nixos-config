{
  homepageConfig = {
    bookmarks = (builtins.readFile ./bookmarks.yaml);
    customJs = (builtins.readFile ./custom.js);
    customCSS = (builtins.readFile ./custom.css);
    docker = (builtins.readFile ./docker.yaml);
    kubernetes =(builtins.readFile ./kubernetes.yaml);
    services =(builtins.readFile ./services.yaml);
    settings =(builtins.readFile ./settings.yaml);
    widgets =(builtins.readFile ./widgets.yaml);
  };
}

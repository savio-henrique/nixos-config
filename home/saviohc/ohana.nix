{ config, pkgs, ... }:
let
  mcsv = pkgs.writeShellScriptBin "mcsv" ''
    # mcsv - Minecraft Server tmux script
    first_arg=$1;
    if [ -z "$first_arg" ] ; then
      echo "Please provide a servername."
      exit 1
    fi

    tmux -S /run/minecraft/"$first_arg".sock attach
  '';
in { 
  imports = [ 
    (import ./home.nix {base16 = "black-metal-dark-funeral";})
    ../common ]; 
  home.packages = [
    mcsv
  ];
}

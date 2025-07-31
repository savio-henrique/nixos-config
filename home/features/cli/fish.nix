{ pkgs, config, lib, ...}:
let
  # Rebuild config command
  ssh-rebuild = pkgs.writeShellScriptBin "ssh-rebuild" ''
    # ssh-rebuild - Rebuild NixOS configuration over SSH
    # Usage: ssh-rebuild <host> 
    # Example: ssh-rebuild myhost

    # Colors
    RED='\033[0;31m'

    first_arg=$1;

    # Check if the first arg is empty
    if [ -z "$first_arg" ] ; then
      echo -e "''${RED}Please provide a host name."
      exit 0
    fi

    # Check if the first arg is a valid host
    if ! [ -z "$(ssh -G $first_arg 2>&1 | grep 'Could not resolve hostname')" ]; then
      echo -e "''${RED}Invalid host name."
      exit 0
    fi

    nixos-rebuild switch --flake .#$first_arg --target-host $first_arg --use-remote-sudo --show-trace
  '';
in {
  # Fish config
  programs.fish = {
    enable = true;
    # shellInit = ''
    #   echo -e "\033[4;35m'Nenhum cidadão tem o direito de ser um amador em matéria de treinamento físico. Que desgraça é para o homem envelhecer sem nunca ver a beleza e a força do que o seu corpo é capaz.'\033[0m \033[1;35m- \033[1;95m Sócrates";
    #   '';
  };

  home.packages = [
    ssh-rebuild
  ];

  # Aliases
  home.shellAliases = {
    # Normal aliases
    c = "clear";
    v = "nvim";
    e = "exit";

    # Nixos Aliases
    rebuild = "sudo nixos-rebuild switch --flake ./#chrono";
    perms = "sudo chmod -R 775 /etc/nixos && sudo chown -R root:nixos-dev /etc/nixos";
    flake = "nix flake update";
    dev = "nix develop --command fish";
  };
}

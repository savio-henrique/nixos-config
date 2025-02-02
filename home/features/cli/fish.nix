{ pkgs, config, lib, ...}:
{
  # Fish config
  programs.fish = {
    enable = true;
    shellInit = ''
      echo -e "\033[4;35m'Nenhum cidadão tem o direito de ser um amador em matéria de treinamento físico. Que desgraça é para o homem envelhecer sem nunca ver a beleza e a força do que o seu corpo é capaz.'\033[0m \033[1;35m- \033[1;95m Sócrates";
      '';
  };

  # Aliases
  home.shellAliases = {
    # Normal aliases
    c = "clear";
    v = "nvim";
    e = "exit";

    # Nixos Aliases
    rebuild = "sudo nixos-rebuild switch --flake \'/etc/nixos#saviohc\'";
    perms = "sudo chmod -R 775 /etc/nixos && sudo chown -R root:nixos-dev /etc/nixos";
    flake = "nix flake update";
    dev = "nix develop --command fish";
  };
}

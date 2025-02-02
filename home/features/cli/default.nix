{pkgs, ...}: {
  imports = [
    ./git.nix
    ./fish.nix
    ./tmux
  ];
  home.packages = with pkgs; [
    htop
    unzip
    neofetch
  ];
}

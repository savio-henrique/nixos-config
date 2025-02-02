{pkgs, ...}: {
  imports = [
    ./git.nix
    ./fish.nix
    ./tmux
  ];
  home.packages = with pkgs; [
    htop
    curl
    unzip
    neofetch
    xorg.xev
    fwupd
    tree
    wget
    ripgrep
  ];
}

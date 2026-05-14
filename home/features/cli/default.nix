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
    fastfetch
    xev
    fwupd
    tree
    wget
    ripgrep
  ];
}

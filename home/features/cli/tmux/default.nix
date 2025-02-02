{pkgs, config, lib, ...}:
{
  programs.tmux = {
    enable = true;
  };

  home.shellAliases = {
    # Tmux Aliases
    m = "tmux";
    ma = "tmux attach -t";
    mr = "tmux rename-session -t";
  };
}

{pkgs, config, lib, ...}:
{
  programs.tmux = {
    enable = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      resurrect
      better-mouse-mode
      vim-tmux-navigator
    ];

    extraConfig = ''
      # Set tmux to use colors accordingly
      set -g default-terminal "tmux-256color"
      set -g default-command ${pkgs.fish}/bin/fish
      set -as terminal-overrides ',xterm*:Tc'
    '';
  };


  home.shellAliases = {
    # Tmux Aliases
    # TODO - 
    # Add command to open tmux with one vertical split and two horizontal splits
    m = "tmux new-session -A -s default";
    ma = "tmux attach -t";
    mr = "tmux rename-session -t";
    ml = "tmux list-sessions";
    mk = "tmux kill-session -t";
    mi = "tmux i";
  };
}

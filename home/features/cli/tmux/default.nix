{pkgs, config, lib, ...}:
let 
  tis = pkgs.writeShellScriptBin "tis" ''
    # tis - tmux ide session initializer
    # This script initializes a tmux session with a specific layout for development work.

    # Colors
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    BLUE='\033[0;34m'
    PURPLE='\033[0;35m'
    CYAN='\033[0;36m'
    LIGHT_GRAY='\033[0;37m'
    WHITE='\033[1;37m'
    CLEAR='\033[0m'
    
    helper_message() {
      echo -e "    ''${BLUE}Tmux IDE Session Initializer''${CLEAR}"
      echo -e "    ''${LIGHT_GRAY}------------------------------''${CLEAR}"
      echo -e "    ''${WHITE}Usage: ''${BLUE}tis ''${CYAN}<command>''${CLEAR}" 
      echo -e "    ''${WHITE}Description: ''${LIGHT_GRAY}This script initializes a tmux session with a specific layout for development work. It creates a new tmux session named 'work' with three panes: the first pane runs nvim, the second pane runs the provided command, and the third pane is left empty for additional commands or monitoring.''${CLEAR}"
      echo -e ""
      echo -e "    ''${WHITE}Usage Example: ''${CYAN}tis htop''${CLEAR}"
      echo -e "    This will open a tmux session with nvim in the first pane and htop running in the second pane."
      echo -e ""
      echo -e "    If you provide no arguments, it will have the second pane empty and ready for you to run any command you want."
      echo -e "    ''${LIGHT_GRAY}---------------------------------''${CLEAR}"
      echo -e "    Options:"
      echo -e "    ''${GREEN}command''${CLEAR}: The command to run in the second pane of the tmux session. If no command is provided, the second pane will be left empty."
      echo -e "    -h, --help: Show this help message and exit."
      echo -e "    ''${LIGHT_GRAY}---------------------------------''${CLEAR}"
    }

    first_arg=$1;

    # Check if the first arg is asking for help

    if [ "$first_arg" = "-h" ] || [ "$first_arg" = "--help" ]; then
      helper_message
      exit 0
    fi

    if (tmux has-session -t work 2>/dev/null); then
      echo -e "''${YELLOW}Tmux session 'work' already exists. Attaching to it...''${CLEAR}"
      tmux attach-session -t work
      exit 0
    fi
    tmux new-session -d -s work
    tmux split-window -v -d
    tmux resize-pane -D 10
    tmux split-window -h
    tmux resize-pane -R 10
    tmux send-keys -t work.0 "nvim" C-m
    tmux send-keys -t work.1 $* C-m
    tmux rename-window -t work "IDE"
    tmux attach-session -t work
  '';

in {
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

  home.packages = [
    tis
  ];

  home.shellAliases = {
    # Tmux Aliases
    m = "tmux new-session -A -s default";
    ma = "tmux attach -t";
    mr = "tmux rename-session -t";
    ml = "tmux list-sessions";
    mk = "tmux kill-session -t";
    mi = "tmux i";
  };
}

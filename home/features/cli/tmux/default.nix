{pkgs, config, lib, ...}:
let 
  tis = pkgs.writeShellScriptBin "tis" ''
    # tis - tmux ide session initializer
    # This script initializes a tmux session with a specific layout for development work.

    session_name="work"
    ide_number=1
    is_attached=false

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
      echo -e "    -s, --session ''${CYAN}session_name''${CLEAR}: Specify a custom name for the tmux session instead of the default 'work'."
      echo -e "    ''${LIGHT_GRAY}---------------------------------''${CLEAR}"
    }

    first_arg=$1;

    # Check if the first arg is asking for help

    if [ "$first_arg" = "-h" ] || [ "$first_arg" = "--help" ]; then
      helper_message
      exit 0
    fi

    if [ "$first_arg" = "-s" ] || [ "$first_arg" = "--session" ]; then
      session_name=$2
      shift 2
    fi

    if [ -n "$TMUX" ]; then
      is_attached=true
      session_name=$(tmux display-message -p '#S')
    fi

    create_ide() {
      tmux split-window -v -d
      tmux resize-pane -D 10
      tmux split-window -h
      tmux resize-pane -R 10
      tmux send-keys -t ''${session_name}.0 "nvim" C-m
      tmux send-keys -t ''${session_name}.1 $* C-m
      tmux rename-window -t ''${session_name} "IDE-''${ide_number}"
    }

    create_new_ide() {
      current_window_count=$(tmux list-windows -t ''${session_name} | grep -c "IDE")
      ide_number=$(( $current_window_count + 1))

      if [ "$is_attached" = false ] || [[ $(tmux list-panes -t ''${session_name} | wc -l) -gt 1 ]]; then
        tmux new-window -t ''${session_name}
      fi
      create_ide $*
    }

    if (tmux has-session -t ''${session_name} 2>/dev/null); then

      create_new_ide $*
      if [ "$is_attached" = false ]; then
        tmux attach-session -t ''${session_name}
      fi
      exit 0
    else
      tmux new-session -d -s ''${session_name}
      create_ide
      tmux attach-session -t ''${session_name}
      exit 0
    fi
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

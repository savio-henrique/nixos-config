{pkgs, config, lib, ...}:
let 
  tis = pkgs.writeShellScriptBin "tis" ''
    # tis - tmux ide session initializer
    # This script initializes a tmux session with a specific layout for development work.

    session_name="work"
    ide_number=1
    is_attached=false
    command_to_run=""
    path_to_directory="./"

    OPTSTRING=":hs:p:"

    # Map long options to short ones and rebuild argv
    translated=()
    while (( $# )); do
      case "$1" in
        --help)    translated+=("-h"); shift ;;
        --session) translated+=("-s"); shift ;;
        --path=*)
          echo "Processing --file with argument: ''${1#*=}"
          if [ -n "''${1#*=}" ]; then
            translated+=("-p" "''${1#*=}");
            shift
          else
            echo "''${RED}ERROR:''${CLEAR} --path option requires an argument"
            exit 1
          fi
          ;;
        --path)    
          if [ -n "$2" ] && [[ "$2" != -* ]]; then
            translated+=("-p" "$2"); shift 2
          else
            echo "''${RED}ERROR:''${CLEAR} --path option requires an argument"
            exit 1
          fi
          ;;
        --)        translated+=("--"); shift; translated+=("$@"); set -- ;;
        *)         translated+=("$1"); shift ;;
      esac
    done
    set -- "''${translated[@]}"

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
      echo -e "    -p, --path ''${CYAN}path_to_directory''${CLEAR}: Specify a custom path to start the tmux session in. If not provided, it will start in the current directory."
      echo -e "    ''${LIGHT_GRAY}---------------------------------''${CLEAR}"
    }

    first_arg=$1;
    second_arg=$2;

    # Check if the first arg and second arg are non-option arguments (not starting with '-')
    if [[ $first_arg != "-"* ]]; then
      command_to_run="$first_arg"
      shift
      if [[ -n $second_arg ]] && [[ $second_arg != "-"* ]] ; then
        echo -e "''${RED}ERROR:''${CLEAR}Only one non-option argument is allowed, but got: ''${YELLOW}$first_arg''${CLEAR} and ''${YELLOW}$second_arg''${CLEAR}"
        exit 1
      fi
    fi

    # Process options

    while getopts $OPTSTRING opt; do
      case "$opt" in
        h) helper_message; exit 0;;
        s) session_name="$OPTARG";;
        p) path_to_directory="$OPTARG";;
        :)
          echo "Missing argument for -$OPTARG"; exit 1;;
        \?) echo "Invalid option: -$OPTARG"; exit 1;;
        *) echo "Unexpected error while processing options"; exit 1;;
      esac
    done
    shift $((OPTIND - 1))

    # Check if the last argument is the command to run (if it wasn't already set by the first non-option argument)
    for last in "$@"; do true; done
    if [[ -n $last ]]; then
      if [[ -n $command_to_run ]]; then
        echo -e "''${RED}ERROR:''${CLEAR} Command specified ($command_to_run) but last argument is not empty ($last)"
        exit 1
      else
        command_to_run="$last"
        shift
      fi
    fi

    # Check if there are any non-option arguments left after processing options
    if [[ $# -gt 0 ]]; then
      echo -e "''${RED}ERROR:''${CLEAR} Unexpected non-option arguments after options: $@"
      exit 1
    fi

    # Check if we're already inside a tmux session
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
      tmux send-keys -t ''${session_name}.1 ''${command_to_run} C-m
      tmux rename-window -t ''${session_name} "IDE-''${ide_number}"
    }

    create_new_ide() {
      current_window_count=$(tmux list-windows -t ''${session_name} | grep -c "IDE")
      ide_number=$(( $current_window_count + 1))

      if [ "$is_attached" = false ] || [[ $(tmux list-panes -t ''${session_name} | wc -l) -gt 1 ]]; then
        tmux new-window -t ''${session_name}
        cd ''${path_to_directory} || exit 1
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
      cd ''${path_to_directory} || exit 1
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

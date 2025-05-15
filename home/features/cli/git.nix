{ pkgs, config, lib, ... }: 
let
  gc = pkgs.writeShellScriptBin "gc" ''
    # gc - git conventional commit script

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

    first_arg=$1;
    second_arg=$2;
    third_arg=$3;
    message=""


    helper_message () {
      echo -e "    ''${BLUE}Git Conventional Commit Helper''${CLEAR}"
      echo -e "    ''${LIGHT_GRAY}------------------------------''${CLEAR}"
      echo -e "    ''${WHITE}Usage: ''${BLUE}gc ''${CYAN}<type> ''${WHITE}<message> ''${YELLOW}<scope>''${CLEAR}" 
      echo -e "    or ''${BLUE}gc ''${CYAN}<type> ''${WHITE}<message>''${CLEAR}" 
      echo -e "    or ''${BLUE}gc ''${WHITE}<message>''${CLEAR}"
      echo -e "    ''${WHITE}Types: ''${GREEN}feat, fix, docs, style, refactor, perf, test, chore''${CLEAR}"
      echo -e "    ''${LIGHT_GRAY}------------------------------''${CLEAR}"
      echo -e "    This script helps you to create a conventional commit message."
      echo -e ""
      echo -e "    It takes one to three arguments: being, in order, the type of the commit, the message and the scope."
      echo -e "    ''${WHITE}Usage Example: ''${CYAN}gc feat 'Add new feature' 'Feature'"
      echo -e "    ''${WHITE}Result: ''${GREEN}':sparkles: feat(Feature): Add new feature' ''${CLEAR}"
      echo -e ""
      echo -e "    If you provide two arguments, it will commit the type of the commit and the message."
      echo -e "    ''${WHITE}Usage Example: ''${CYAN}gc feat 'Add new feature'"
      echo -e "    ''${WHITE}Result: ''${GREEN}':sparkles: feat: Add new feature' ''${CLEAR}"
      echo -e ""
      echo -e "    If you provide only one argument, it will commit with the message only."
      echo -e "    ''${WHITE}Usage Example: ''${CYAN}gc 'Add new feature'"
      echo -e "    ''${WHITE}Result: ''${GREEN}'Add new feature' ''${CLEAR}"
      echo -e ""
      echo -e "    If you provide no arguments, it will show this help message."
      echo -e "    ''${LIGHT_GRAY}---------------------------------''${CLEAR}"
    }

    # Check if the first arg is empty
    if [ -z "$first_arg" ] ; then
      helper_message
      exit 1
    else 
      # Check if the first arg is a type and the second arg is empty
      if [ "$first_arg" = "feat" ] || [ "$first_arg" = "fix" ] || [ "$first_arg" = "docs" ] || [ "$first_arg" = "style" ] || [ "$first_arg" = "refactor" ] || [ "$first_arg" = "perf" ] || [ "$first_arg" = "test" ] || [ "$first_arg" = "chore" ] && [ -z "$second_arg" ]; then
        echo -e "''${RED}Please provide a commit message."
        exit 0
      fi
    fi
    # Check if the first arg is asking for help

    if [ "$first_arg" = "-h" ] || [ "$first_arg" = "--help" ]; then
      helper_message
      exit 0
    fi

    # Check if the first arg is a valid commit type
    case $first_arg in 
      feat)
        message=":sparkles: $first_arg"
        ;;
      fix)
        message=":wrench: $first_arg"
        ;;
      docs)
        message=":pencil: $first_arg"
        ;;
      style)
        message=":paintbrush: $first_arg"
        ;;
      refactor)
        message=":gear: $first_arg"
        ;;
      perf)
        message=":bar_chart: $first_arg"
        ;;
      test)
        message=":test_tube: $first_arg"
        ;;
      chore)
        message=":broom: $first_arg"
        ;;
      *)
        if [ -z "$second_arg" ]; then
          message=$first_arg
        else 
          echo -e "''${RED}Wrong type. Please provide a valid type."
          exit 0
        fi
        ;;

    esac

    if ! [ -z "$third_arg" ]; then
      full_message="''${message}(''${third_arg}): $second_arg"
    else
      # Check if the second arg is empty
      if ! [ -z "$second_arg" ]; then
        full_message="''${message}: $second_arg"
      else
        full_message="$message"
      fi
    fi

    # Validates message with the user
    echo -e "''${WHITE}Your commit message is:\n\n''${GREEN}'$full_message' ''${WHITE}\n\nAre you sure? (''${GREEN}[y]es''${WHITE}/''${RED}[n]o''${WHITE}): ''${CLEAR}"
    read answer
    if [ "$answer" = "y" ] || [ "$answer" = "yes" ]; then
      # Commits message
      git commit -m "$full_message"
    else 
      echo -e "''${RED}Please try again with a valid commit message."
      exit 0
    fi
    '';
in {
  home.packages = [
    gc
  ];

  # Git configs
  programs.git = {
    enable = true;
    userName = "Sávio Henrique";
    userEmail = "savio.c.mendes@gmail.com";

    aliases = {
      remotes = "remote -v";
    };
  
    extraConfig = {
      color.ui = true;
      core.askPass = "";
      github.user = "savio-henrique";
      init.defaultBranch = "main";
      safe.directory = [
        "/etc/nixos"
        "/Projects/*"
      ];
    };
  };

  home.shellAliases = {
    # Git Aliases
    gs = "git status";
    gcm = "git commit -m";
    gcl = "git clone";
    gpl = "git pull";
    gp = "git push";
    ga = "git add";
    gaa = "git add --all";
    gl = "git log --oneline --graph --decorate -n 15";
    gd = "git diff";
    gr = "git restore";
    grs = "git restore --staged";
    gch = "git checkout";
  };
}

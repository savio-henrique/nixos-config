{ pkgs, config, lib, ... }: 
let
  gc = pkgs.writeShellScriptBin "gc" ''
    # gc - git conventional commit script

    first_arg=$1;
    second_arg=$2;

    helper_message () {
      echo "    Git Conventional Commit Helper"
      echo "------------------------------"
      echo "    Usage: gc <type> <message> or gc <message>"
      echo "    Types: feat, fix, docs, style, refactor, perf, test, chore"
      echo "------------------------------"
      echo "    This script helps you to create a conventional commit message."
      echo ""
      echo "    It takes two arguments: the type of the commit and the message."
      echo "    Example: gc feat 'Add new feature'\n"
      echo ""
      echo "    If you provide only one argument, it will commit with the message only."
      echo "    Example: gc 'Add new feature'"
      echo ""

      echo "    If you provide no arguments, it will show this help message."
      echo "---------------------------------"
    }

    # Check if the first arg is empty
    if [ -z "$first_arg" ] ; then
      helper_message
      exit 1
    else 
      # Check if the first arg is a type and the second arg is empty
      if [ "$first_arg" = "feat" ] || [ "$first_arg" = "fix" ] || [ "$first_arg" = "docs" ] || [ "$first_arg" = "style" ] || [ "$first_arg" = "refactor" ] || [ "$first_arg" = "perf" ] || [ "$first_arg" = "test" ] || [ "$first_arg" = "chore" ] && [ -z "$second_arg" ]; then
        echo "Please provide a commit message."
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
        echo ":sparkles: $first_arg: $second_arg"
        ;;
      fix)
        echo ":wrench: $first_arg: $second_arg"
        ;;
      docs)
        echo ":pencil: $first_arg: $second_arg"
        ;;
      style)
        echo ":framed_picture: $first_arg: $second_arg"
        ;;
      refactor)
        echo ":gear: $first_arg: $second_arg"
        ;;
      perf)
        echo ":bar_chart: $first_arg: $second_arg"
        ;;
      test)
        echo ":test_tube: $first_arg: $second_arg"
        ;;
      chore)
        echo ":broom: $first_arg: $second_arg"
        ;;
      *)
        if [ -z "$second_arg" ]; then
          echo "Your commit message is: '$first_arg'. Are you sure? ([y]es/[n]o)"
          read answer
          if [ "$answer" = "y" ] || [ "$answer" = "yes" ]; then
            echo "$first_arg"
            exit 0
          else 
            echo "Please provide a valid message."
            exit 0
          fi
        else 
          echo "Please provide only one message."
          exit 0
        fi
        ;;

    esac
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
        # "/etc/nixos/dotfiles/awesome/awesome-wm-widgets"
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
    gl = "git log";
    gd = "git diff";
    gr = "git restore";
    grs = "git restore --staged";
    gch = "git checkout";
  };
}

{ config, pkgs, inputs, ... }:

{
	# Imports
  imports = [
		inputs.nix-colors.homeManagerModules.default
		./programs/alacritty/alacritty.nix
		./programs/nvim/nvim.nix
		# ./programs/freecad/freecad.nix
	];

	colorScheme = inputs.nix-colors.colorSchemes.twilight;

	# User config
  home.username = "saviohc";
  home.homeDirectory = "/home/saviohc";
  # Version
  home.stateVersion = "23.11"; 

  # Nixpkgs config
  nixpkgs.config.allowUnfree = true;

  # Packages
  home.packages = with pkgs; [
		ffmpeg
		vlc
		davinci-resolve
    flameshot
    discord
    vesktop
    docker
    docker-compose
    spotify
    brave
    alacritty
    neofetch
    helvum

    # Utils
    onlyoffice-bin
    libreoffice
    corefonts
    unzip
    gimp
    obsidian

    # Widget Utils
    acpi
    brightnessctl
    alsa-utils

    # Games
    prismlauncher
    osu-lazer
  ];

  # File links
  home.file = with config.colorScheme.palette; {
    ".config/neofetch".source = dotfiles/neofetch;
    ".config/awesome" = {
			  source = dotfiles/awesome;
        recursive = true;
      };

    ".config/awesome/awesome-wm-widgets" = {
      source = builtins.fetchGit {
        url = "https://github.com/streetturtle/awesome-wm-widgets.git";
        rev = "68ddbd9812979f1862ebd07f1bf5aa409952e935";
      };
      recursive = true;
    };

    ".config/awesome/icons" = {
      source = builtins.fetchGit {
        url = "https://github.com/streetturtle/awesome-wm-widgets.git";
        rev = "68ddbd9812979f1862ebd07f1bf5aa409952e935";
      };
      recursive = true;
    };

   	".config/awesome/theme/colors.lua" = {
			target = ".config/awesome/theme/colors.lua";
			text = ''
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local theme = {}

-- Theme Colors
theme.bg_normal     = "#${base00}"
theme.bg_focus      = "#${base03}"
theme.bg_urgent     = "#${base08}"
theme.bg_minimize   = "#${base02}"
theme.bg_systray    = theme.bg_normal
	
theme.fg_normal     = "#${base06}"
theme.fg_focus      = "#${base07}"
theme.fg_urgent     = "#${base07}"
theme.fg_minimize   = "#${base07}"

	
theme.useless_gap   = dpi(4)
theme.border_width  = dpi(2)
theme.border_normal = "#${base0F}"
theme.border_focus  = "#${base09}"
theme.border_marked = "#${base0E}"
	
theme.titlebar_bg_color  = theme.border_focus
theme.titlebar_fg_color  = theme.border_focus
	
theme.tasklist_bg_focus  = theme.border_focus
theme.tasklist_bg_normal = theme.border_normal
theme.taglist_bg_normal  = theme.border_normal
theme.taglist_bg_focus   = theme.border_focus
	
return theme
			'';
  	};
	};
	
  # Session Variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Program Config
  programs = {

    # Fish config
    fish = {
      enable = true;
      shellInit = ''
        echo -e "\033[4;35m'Nenhum cidadão tem o direito de ser um amador em matéria de treinamento físico. Que desgraça é para o homem envelhecer sem nunca ver a beleza e a força do que o seu corpo é capaz.'\033[0m \033[1;35m- \033[1;95m Sócrates";
      '';
    };

    # Git configs
    git = {
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
          "/etc/nixos/dotfiles/awesome/awesome-wm-widgets"
        ];
      };
    };
  };

  # Bash alias
  home.shellAliases = {
    c = "clear";
    e = "exit";
    gs = "git status";
    gc = "git commit -m";
    gcl = "git clone";
    gpl = "git pull";
    gp = "git push";
    ga = "git add";
    gaa = "git add --all";
    gl = "git log";
    gd = "git diff";
    gr = "git restore";
    grs = "git restore --staged";
    v = "nvim";
    rebuild = "sudo nixos-rebuild switch --flake \'/etc/nixos#saviohc\'";
    perms = "sudo chmod -R 775 /etc/nixos && sudo chown -R root:nixos-dev /etc/nixos";
    flake = "nix flake update";
    m = "tmux";
    ma = "tmux attach -t";
    mr = "tmux rename-session -t";
    dev = "nix develop --command fish";
  };

  programs.home-manager.enable = true;
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs; [
      obs-studio-plugins.input-overlay
      obs-studio-plugins.obs-multi-rtmp
      obs-studio-plugins.obs-composite-blur
      obs-studio-plugins.obs-move-transition
      obs-studio-plugins.obs-pipewire-audio-capture
      obs-studio-plugins.obs-teleport
    ];
  };
}

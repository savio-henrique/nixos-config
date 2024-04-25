{ config, pkgs, inputs, ... }:

{
  # TODO -- add as a home-manager module: imports = [ ./programs/nvim/nvim.nix ];

  home.username = "saviohc";
  home.homeDirectory = "/home/saviohc";

  # Version
  home.stateVersion = "23.11"; 

  # Nixpkgs config
  nixpkgs.config.allowUnfree = true;

  # Packages
  home.packages = with pkgs; [
    obs-studio
    flameshot
    discord
    jetbrains.pycharm-community
    jetbrains.phpstorm
    docker
    docker-compose
    spotify
    gimp
    brave
    alacritty
    neofetch
    nitrogen
    minecraft
  ];

  # File links
  home.file = {
    ".config/awesome".source = dotfiles/awesome;
    ".config/alacritty".source = dotfiles/alacritty;
    ".config/nitrogen".source = dotfiles/nitrogen;
    ".config/neofetch".source = dotfiles/neofetch;
    ".config/picom".source = dotfiles/picom;
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
      };
    };

    # Alacritty configs
    alacritty = {
      enable = true;

      settings = {
	window = {
	  opacity = 0.2;
	  title = "Terminal";
	  dynamic_title = false;
	  colors.primary = {
	    foreground = "#1158c7";
	    background = "#0d1117";
	  };
	};
      };
    };

    # Neovim config
    neovim = {
        enable = true; 
				
				viAlias = true;
				vimAlias = true;
				vimdiffAlias = true;
  
        extraLuaConfig = ''
	  ${builtins.readFile ./programs/nvim/config/options.lua}
        '';
  
        plugins = with pkgs.vimPlugins; [
					{
					  plugin = comment-nvim;
					  type = "lua";
            config = "require('Comment').setup()";
					}

				  {
				  	plugin = nvim-lspconfig;
						type = "lua";
						config = "${builtins.readFile ./programs/nvim/config/plugin/lsp.lua}";
					}

					{
					  plugin = github-nvim-theme;
						config = "colorscheme github_dark_default";
					}

					# {
					#   plugin = gruvbox-nvim;
					# 	config = "colorscheme gruvbox";
					# }

          #{
					  #plugin = vim-nix;
						#type = "";
						#config = "";
					#}
        ];
      };
  };

  # Bash alias
  home.shellAliases = {
    c = "clear";
    e = "exit";
    gs = "git status";
    gc = "git commit -m";
    gpl = "git pull";
    gp = "git push";
    ga = "git add";
    gaa = "git add --all";
    gl = "git log";
    gd = "git diff";
    gr = "git restore";
    grs = "git restore --staged";
    v = "nvim";
    rebuild = "sudo nixos-rebuild switch --flake '/etc/nixos#saviohc'";
    perms = "sudo chmod -R 775 /etc/nixos && sudo chown -R root:nixos-dev /etc/nixos";
    flake = "nix flake update";
    m = "tmux";
    ma = "tmux attach -t";
    mr = "tmux rename-session -t";
    dev = "nix develop --command fish";
  };

  programs.home-manager.enable = true;
}

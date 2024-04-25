# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ./users/main-user.nix
      ./picom.nix
      ./video.nix
    ];

  # Use the GRUB 2 boot loader.
  # boot.loader.grub.enable = true;
  boot.loader.systemd-boot.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "nodev"; # or "nodev" for efi only

  networking.hostName = "saviohc"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Nixpkg config
  nixpkgs.config.allowUnfree = true;

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # NIXOS Configuration 
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Video Configuration
  video.enable = true;
  video.wm = "awesome";

  # Picom configuration
  picom.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable fish
  programs.fish.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # make pipewire realtime-capable
  security.rtkit.enable = true;

  # udev rule to not suspend usb
  services.udev.extraRules = ''
    ACTION=="add", DRIVER=="usb", ATTR{power/control}:="on"
  '';

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define user groups
  users.groups = {
    docker = { 
      gid = 1003;
    };
    nixos-dev = {
      gid = 1010;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  main-user.enable = true;
  main-user.userName = "saviohc";
  main-user.name = "Savio Henrique";
  main-user.groups = [ "docker" "wheel" "nixos-dev" "users" ];

  # Home Manager config
  home-manager.useGlobalPkgs = true;
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "saviohc" = import ./home.nix;
    };
  };

  # Game configs
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    xterm
    curl
    wget
    htop
    alacritty
    neofetch
    pcmanfm
    git
    tree
    firefox
    dmenu
    tmux
    fwupd
    xorg.xev
    pavucontrol
    usbutils

    rofi
    nitrogen
  ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}


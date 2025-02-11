# :link: My NixOS configuration

A little dive into my ~~madness~~ configuration and its components and modules.

One's personal system configuration is always on WIP, as this is a living beast. Have fun trying to decypher what I'm doing. :laughing:

--- 

## :gear: Reestructured Configuration

Utilizing the SaschaKoenig's [Nixos Config Playlist](https://www.youtube.com/watch?v=43VvFgPsPtY&list=PLCQqUlIAw2cCuc3gRV9jIBGHeekVyBUnC) and Misterio77's [Nixos Config](https://github.com/Misterio77/nix-config) as models and guides, I've reestructured my config as to satisfy these conditions:
* Be more modular;
* Have multiple hosts/users;
* Be more readable and maintainable.
* Be more secure.
* Have different configurations for different machines/hosts.

---
# :sparkles: Future Additions and Changes to my Environment

### :paintbrush: Customization and theming
- [x] Add an 'awesomewm' module with all awesomewm config to work in my visual hosts.
- - [x] Add configurations to have modular widgets working.
- [x] Update the 'picom' module to work with all visual hosts.
- [x] Add a 'rofi' module to work in my visual hosts.
- [x] Add a 'vesktop' module to work in my visual hosts.
- [x] Add a 'shell' module with all shell config.
- - [x] Add a 'fish' module with all fish config to work throughout my hosts. [Wiki](https://nixos.wiki/wiki/Fish)
- - [x] Add an 'aliases' module to set my aliases across the hosts.
> [!NOTE]
> Aliases are set on the module that it is related
- [x] Add an 'alacritty' module with all alacritty config to work in my visual hosts.
- [x] Add a 'tmux' module with all tmux config throughout my hosts. [Wiki](https://nixos.wiki/wiki/Tmux)
- - [ ] Add new tmux configs
- - [ ] Add new tmux custom theming. Like [this](https://github.com/janoamaral/tokyo-night-tmux)
- [x] Update the 'neovim' module with all neovim config to work throughout my hosts. [Wiki](https://nixos.wiki/wiki/Neovim)
- [ ] Add a 'spotify'/'spicetify' module to work on visual hosts.
- - [ ] Add support for spotify specific widget on awesomewm.
- - [ ] Add playerctl support for spotify.

### :computer: Environment stuff
- [x] Add an 'openssh' module to work on all my hosts.
- [x] Add an 'git' module to work in my hosts.
- - [x] Add git conventional commits function to my shell.
- [x] Add a 'obs-studio' module to work in my visual hosts.
- [x] Add a 'minecraft-server' module to use on ohana.
- [ ] Add a 'sound' module to work in my visual hosts.
- - [ ] Add playerctl config. [PlayerCtl](https://github.com/altdesktop/playerctl)
- [ ] Add a 'gaming' module to work in my gaming hosts.

### :lock: Hard stuff
- [x] Add 'sops-nix' to my configuration to encrypt secrets.
- [ ] Add a 'docker' module to work on all my hosts.
- [ ] Add a 'kubernetes' module to work on all my hosts.
- [ ] Add a 'virtualization' module to work in my hosts.
- [ ] Add a 'webserver' module to use on cyrus.


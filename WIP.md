# :sparkles: Future Additions and Changes to my Environment

### :paintbrush: Customization and theming
- [x] Add an 'awesomewm' module with all awesomewm config to work in my visual hosts.
- - [x] Add configurations to have modular widgets working.
- - [ ] Turn terminal configuration on 'rc.lua' dynamical and configurable by feature flag
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
- - [x] Add new tmux configs
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

### :house: Homelab stuff

#### OCI Containers
- [x] Add virtualization module to work with OCI Containers.
- - [ ] Migrate containers to the virtualization module.

#### k3s
- [ ] Add a 'k3s' module to work on all my hosts.
- - [ ] Migrate container services to k3s.

#### Services
- [ ] Add 'firefly-iii'.
- - [x] As a oci-container.
- - [ ] As a k3s service.
- [ ] Add 'vaultwarden'.
- - [ ] As a oci-container.
- - [ ] As a k3s service.
- [ ] Add 'pi-hole' and 'unbound'.
- - [x] As a oci-container.
- - [ ] As a k3s service.
- [ ] Add 'homepage'.
- - [x] As a oci-container.
- - [ ] As a k3s service.

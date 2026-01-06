# :snowflake: My NixOS configuration

A little dive into my ~~madness~~ configuration and its components and modules.

One's personal system configuration is always on [WIP](./WIP.md) as this is a living beast. Have fun trying to decypher what I'm doing. :laughing:


## :gear: Reestructured Configuration

Utilizing the SaschaKoenig's [Nixos Config Playlist](https://www.youtube.com/watch?v=43VvFgPsPtY&list=PLCQqUlIAw2cCuc3gRV9jIBGHeekVyBUnC) and Misterio77's [Nixos Config](https://github.com/Misterio77/nix-config) as models and guides, I've reestructured my config as to satisfy these conditions:
* Be more modular;
* Have multiple hosts/users;
* Be more readable and maintainable.
* Be more secure.
* Have different configurations for different machines/hosts.

---

# :sparkles: Features

* **Multi-host NixOS configuration**, allowing for different configurations per host, like **server**, **laptop**, **desktop**.
* Declarative **Theming and Customization** in most of the applications
* Declarative Self-hosted containerized services like *Firefly III*, *TriliumNext* and *Pi-hole*, using OCI containers.
* Secret management using [ **sops-nix** ](https://github.com/Mic92/sops-nix).

## :art: Theming and Customization

* **AwesomeWM** configuration with modular widgets.
* **Picom** Compositor configuration for visual hosts.
* Declarative theming and background configuration with Misterio77's **nix-colors** per host for
  * AwesomeWM
  * Alacritty
  * Neovim
  * Rofi
  * Vesktop
  * Tmux (WIP)

## :package: Containers and Services

* Containerized self-hosted services tunneling via **Tailscale VPN** or **Cloudflare Tunnels**
* Secure secret management with [ **sops-nix** ](https://github.com/Mic92/sops-nix)
* Self-hosted services
  * [Firefly III](https://github.com/firefly-iii/firefly-iii)
  * Pi-Hole
  * [Homepage](https://github.com/gethomepage/homepage)
  * [TriliumNext](https://github.com/TriliumNext/Trilium)
  * [Kaneo](https://github.com/usekaneo/kaneo)
  * Vaultwarden (WIP)
  * Grafana (WIP)
  * Prometheus (WIP)
---

*See my next additions and changes on [WIP.md](./WIP.md)*

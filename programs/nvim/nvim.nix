#TODO -- modularize the neovim configuration using home-manager modules.

{ lib, pkgs, config , ... }:

let
  cfg = config.neovim;
in
{
  options.neovim = {
    enable = lib.mkDefault true;
  };

  config = lib.mkIf cfg.enable {
    programs.neovim = 
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = path: "lua << EOF\n${builtins.readFile path}\nEOF\n";
    in
    {
      extraLuaConfig = ''
	${builtins.readFile ./config/options.lua}
      '';

      #plugins = with pkgs.vimPlugins; [
      #];
    };
  };
}

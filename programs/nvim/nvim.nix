{ lib, pkgs, config , ... }:

let
  cfg = config.neovim;
in
{
  options.neovim = {
    enable = lib.mkEnableOption "enable neovim configuration";
    
  };

  config = lib.mkIf cfg.enable {
    programs.neovim = 
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = path: "lua << EOF\n${builtins.readFile path}\nEOF\n";
    in
    {
      enable = true;

      extraLuaConfig = ''
	${builtins.readFile ./config/options.lua}
      '';

      #plugins = with pkgs.vimPlugins; [
      #];
    };
  };
}

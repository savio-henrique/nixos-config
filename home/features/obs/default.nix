{pkgs, config, lib, ...}:
{
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

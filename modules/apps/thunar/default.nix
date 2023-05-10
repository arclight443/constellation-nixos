{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.constellation.apps.thunar;
in
{
  options.constellation.apps.thunar = with types; {
    enable = mkBoolOpt false "Whether or not to enable Thunar file manager.";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      ffmpeg
      ffmpegthumbnailer
    ];

    services.gvfs.enable = true;
    services.tumbler.enable = true;

    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
      ];
    };
  };
}

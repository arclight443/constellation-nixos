{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.constellation.cli-apps.ytdlp;
in
{
  options.constellation.cli-apps.ytdlp = with types; {
    enable = mkBoolOpt false "Whether or not to enable yt-dlp.";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      yt-dlp
      ffmpeg
    ];

  };
}

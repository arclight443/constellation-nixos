{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.suites.desktop;
in
{
  options.constellation.suites.desktop = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable common desktop configuration.";
  };

  config = mkIf cfg.enable {
    constellation = {
      desktop = {
        awesome = enabled;
      };

      cli-apps = {
        ncmpcpp = enabled;
        ddcutil = enabled;
        ranger = enabled;
        ytdlp = enabled;
      };

      apps = {
        keepassxc = enabled;
        firefox = enabled;
        tor-browser = enabled;
        imv = enabled;
        mpv = enabled;
        mullvad = enabled;
        thunar = enabled;
      };
    };
  };
}

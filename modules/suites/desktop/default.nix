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
        river = enabled;
      };

      cli-apps = {
        bluetuith = enabled;
        ncmpcpp = enabled;
        ddcutil = enabled;
        ranger = enabled;
        ytdlp = enabled;
        chatblade = enabled;
      };

      apps = {
        keepassxc = enabled;
        remmina = enabled;
        firefox = enabled;
        ungoogled-chromium = enabled;
        krita = enabled;
        picard = enabled;
        tor-browser = enabled;
        imv = enabled;
        mpv = enabled;
        mullvad = enabled;
        thunar = enabled;
      };

      services = {
        bluetooth = enabled;
      };
    };
  };
}

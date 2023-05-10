{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.awesome;

in
{
  options.constellation.desktop.awesome = with types; {
    enable = mkBoolOpt false "Whether or not to enable AwesomeWM";
  };

  config = mkIf cfg.enable {

    constellation = {
      desktop.addons = {
        x11 = enabled;
        gtk = enabled;
        qt = enabled;
        picom = enabled;
        kitty = enabled;
        rofi = enabled;
        barrier = enabled;
        jumpapp = enabled;
      };

      home.configFile."awesome/" = {
        source = ./config;
        recursive = true;
      };
    };

    services.xserver.windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks
        luadbi-mysql
      ];
    };
  };



}

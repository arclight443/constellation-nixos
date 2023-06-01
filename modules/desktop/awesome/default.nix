{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.awesome;

in
{
  options.constellation.desktop.awesome = with types; {
    enable = mkBoolOpt false "Whether or not to enable awesomeWM.";
  };

  config = mkIf cfg.enable {

    constellation = {
      desktop = {
        utils = {
          dconf = enabled;
          nmapplet = enabled;
          rofi = {
            enable = true;
            display = "x11";
          };
        };
        x11 = {
          common = enabled;
          picom = enabled;
          barrier = enabled;
        };
      };

      home.configFile."awesome/" = {
        source = ./config;
        recursive = true;
      };

      home.configFile."awesome/lain" = {
        source = pkgs.constellation.lain;
        recursive = true;
      };

      home.configFile."awesome/freedesktop" = {
        source = pkgs.constellation.awesome-freedesktop;
        recursive = true;
      };

      home.configFile."awesome/sharedtags" = {
        source = pkgs.constellation.awesome-sharedtags;
        recursive = true;
      };

      home.configFile."awesome/awesome-wm-widgets" = {
        source = pkgs.constellation.awesome-wm-widgets;
        recursive = true;
      };

      home.extraOptions = {
        home.packages = with pkgs; [
          (buildEnv
            {
              name = "scripts";
              paths = [ ./scripts ];
            }
          )

        ];
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

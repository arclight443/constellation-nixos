{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.hyprland;

in
{
  options.constellation.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Whether or not to enable hyprland.";
  };

  config = mkIf cfg.enable {

    constellation = {

      system.env = {
        "NIXOS_OZONE_WL" = "1";
      };

      desktop = {
        wayland = {
          common = enabled;
        };

        utils = {
          dconf = enabled;
          nmapplet = enabled;
          rofi = {
            enable = true;
            display = "wayland";
          };
        };

      };

      home.configFile = {
        "hypr/wall.png".source = ./wall.png;
        "hypr/hyprland.conf".source = ./hyprland.conf;
      };

    };

    programs.hyprland = {
      enable = true;
      xwayland = {
        enable = true;
        hidpi = true;
      };
    };

  };

}

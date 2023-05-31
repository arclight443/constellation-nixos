{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.utils.rofi;

in
{
  options.constellation.desktop.utils.rofi = with types; {
    enable = mkBoolOpt false "Whether or not to enable rofi.";
    display = mkOpt (enum [ "x11" "wayland" ]) "x11" "Whether or not to enable eww for x11 or wayland.";
  };

  config = mkIf cfg.enable {

    constellation.home = {

      configFile."rofi/" = {
        source = ./config;
        recursive = true;
      };

      extraOptions = {

        programs.rofi = {
          enable = true;
          package = if cfg.display == "wayland" then pkgs.rofi-wayland else pkgs.rofi;
          theme = "gruvbox-dark-soft";
        };


        home.packages = with pkgs; [
          (buildEnv
            {
              name = "scripts";
              paths = [ ./scripts ];
            })
        ];
      };
    };
  };
}

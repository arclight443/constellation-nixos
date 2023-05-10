{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.addons.rofi;

in
{
  options.constellation.desktop.addons.rofi = with types; {
    enable = mkBoolOpt false "Whether or not to enable rofi.";
  };

  config = mkIf cfg.enable {

    constellation.home.configFile."rofi/" = {
      source = ./config;
      recursive = true;
    };

    constellation.home.extraOptions = {
      programs.rofi.enable = true;
    };

  };
}

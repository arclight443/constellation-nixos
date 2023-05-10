{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.addons.qt;

in
{
  options.constellation.desktop.addons.qt = with types; {
    enable = mkBoolOpt false "Whether or not to enable QT theming.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libsForQt5.qtstyleplugin-kvantum
    ];

    environment.variables = {
      QT_STYLE_OVERRIDE = "kvantum";
    };

    constellation.home.configFile."Kvantum/" =
      {
        source = ./config;
        recursive = true;
      };

  };
}

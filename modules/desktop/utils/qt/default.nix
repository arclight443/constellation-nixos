{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.utils.qt;
  env = {
    QT_STYLE_OVERRIDE = "kvantum";
  };
  envUpscaled = {
    QT_AUTO_SCREEN_SET_FACTOR = "0";
    QT_SCALE_FACTOR = "2";
    QT_FONT_DPI = "96";
  };

in
{
  options.constellation.desktop.utils.qt = with types; {
    enable = mkBoolOpt false "Whether or not to enable QT theming.";
    uiScaling = mkOpt (enum [ "normal" "enlarged" ]) "normal" "UI scaling to use (enlarged configuration for 14 inch laptop).";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libsForQt5.qtstyleplugin-kvantum
    ];

    constellation.home.configFile."Kvantum/" =
      {
        source = ./config;
        recursive = true;
      };

    environment.variables =
      if cfg.uiScaling == "enlarged"
      then
        env // envUpscaled
      else
        env;
  };
}

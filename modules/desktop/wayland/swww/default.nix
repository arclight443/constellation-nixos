{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.wayland.swww;

in
{
  options.constellation.desktop.wayland.swww = with types; {
    enable = mkBoolOpt false "Whether or not to enable swww.";
  };

  config = mkIf cfg.enable {
    constellation.home.extraOptions = {
      home.packages = with pkgs; [
        swww
      ];
    };
  };
}

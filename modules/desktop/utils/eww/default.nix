{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.utils.eww;

in
{
  options.constellation.desktop.utils.eww = with types; {
    enable = mkBoolOpt false "Whether or not to enable eww.";
    display = mkOpt (enum [ "x11" "wayland" ]) "x11" "Whether or not to enable eww for x11 or wayland.";
  };

  config = mkIf cfg.enable {
    constellation.home.extraOptions = {
      home.packages = if cfg.display == "wayland" then [ pkgs.eww-wayland ] else [ pkgs.eww ];
    };
  };

}

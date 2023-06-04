{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.wayland.misc;

in
{
  options.constellation.desktop.wayland.misc = with types; {
    enable = mkBoolOpt false "Whether or not to enable miscellaneous packages for Wayland.";
  };

  config = mkIf cfg.enable {
    constellation.home.extraOptions = {
      home.packages = with pkgs; [
        wev
        wl-clipboard
      ];
    };
  };
}

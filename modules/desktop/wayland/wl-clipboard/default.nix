{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.wayland.wl-clipboard;

in
{
  options.constellation.desktop.wayland.wl-clipboard = with types; {
    enable = mkBoolOpt false "Whether or not to enable wl-clipboard.";
  };

  config = mkIf cfg.enable {
    constellation.home.extraOptions = {
      home.packages = with pkgs; [
        wl-clipboard
      ];
    };
  };
}

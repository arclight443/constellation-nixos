{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.x11.picom;

in
{
  options.constellation.desktop.x11.picom = with types; {
    enable = mkBoolOpt false "Whether or not to enable picom.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      picom
    ];
  };
}
